//
//  GameScene.m
//  Assignment1
//
//  Created by Bradley Flood on 2015-01-13.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import "GameScene.h"
#import "GameViewController.h"
#import "AudioManager.h"

@implementation GameScene

@synthesize gameIsLost=m_ShowLoseScreen;

-(void)didMoveToView:(SKView *)view
{
    //Setup storyboard pointer
    m_Storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    m_LastTimeInterval = 0.0;
    m_Orbs = [NSMutableArray arrayWithCapacity:MAX_NUMBER_OF_ORBS];
    [self reset];
}

-(void)setViewController:(GameViewController*)gameViewController
{
    m_GameViewController=gameViewController;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //If the orb is paused then we can't control it
    if(m_UserOrb.paused == true)
    {
        return;
    }
    
    //Cycle through the touches
    for(UITouch* touch in touches)
    {
        //Get the touch location
        CGPoint location = [touch locationInNode:self];
        
        [[AudioManager GetInstance] PlayTouchSound];

        //Is there still enough radius left to accelerate
        if(m_UserOrb.radius > ORB_RADIUS_CLICK_AMOUNT)
        {
            //Find the difference between the start point and the end point
            CGPoint diff = CGPointMake(location.x - m_UserOrb.position.x, location.y - m_UserOrb.position.y);
            
            //Determines the angle of the line (the center of the Orb and the mouse click location)
            float angle = (atan2f(diff.y, diff.x) * TO_DEGREES) - 180.0f;
            angle = fmod(angle, 360.0f);
            if(angle < 0.0f)
            {
                angle += 360.0f;
            }
            
            //Calculate how much to reduce the speed by
            float angleDiff = angle - m_UserOrb.angle;
            float pct = 1.0f - (fabsf(angleDiff) / 180.0f);
            float speed = m_UserOrb.speed * pct;
            m_UserOrb.speed = speed;

            //Set the calculated angle
            m_UserOrb.angle = angle;
            
            //Increment the speed
            speed = m_UserOrb.speed + ORB_SPEED_INCREMENT;
            m_UserOrb.speed = speed;
            
            //Reduce the radius by the amount of the jetisoned orb
            float radius = m_UserOrb.radius - (float)ORB_RADIUS_CLICK_AMOUNT;
            m_UserOrb.radius = radius;
            
            //Find the difference between the start point and the end point, here the end points
            //are reversed so we can calculate the angle the jetisoned orb should be
            CGPoint delta = CGPointMake(m_UserOrb.position.x - location.x, m_UserOrb.position.y - location.y);
            
            //Calculate the length of the line
            float magnitude = sqrtf(delta.x * delta.x + delta.y * delta.y);
            
            //Normalize the vector
            delta.x /= magnitude;
            delta.y /= magnitude;
            
            //Calculate the jetisoned orb's position
            float x = (int)((float)location.x + delta.x * (magnitude - m_UserOrb.radius * 1.2f));
            float y = (int)((float)location.y + delta.y * (magnitude - m_UserOrb.radius * 1.2f));
            
            //Spawn the jetisoned orb
            [self spawnOrb:CGPointMake(x, y) radius:ORB_RADIUS_CLICK_AMOUNT angle:m_UserOrb.angle - 180.0f speed:ORB_MIN_SPEED];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    //Calculate the delta time
    double delta = currentTime - m_LastTimeInterval;
    m_LastTimeInterval = currentTime;
    
    float remainingRadius=0.0f;
    for(OrbNode* orbA in m_Orbs)
    {
        if(m_UserOrb!=orbA)
            remainingRadius += [orbA radius];
    }
    
    //Safety check the delta time
    if(delta < 1.0)
    {
        
        //Cycle through the Circle objects in the array
        for(OrbNode* orbA in m_Orbs)
        {
            
            for(OrbNode* orbB in m_Orbs)
            {
                if(orbA != orbB)
                {
                    //Calculate the collision overlap and handle any collision
                    float overlap = [self calculateOverlap:orbA OrbB:orbB];
                    if(overlap > 0.0f)
                    {
                        [self handleCollision:orbA OrbB:orbB Overlap:overlap];
                    }
                }
            }
            
            //Update the orb
            [orbA update:delta];
            
            //Safety check the circle object
            if([orbA isPaused] == false && m_UserOrb != nil)
            {
                //Set the circle object's color based on its radius compared to the user controller circle
                if(orbA != m_UserOrb)
                {
                    if([orbA radius] <= [m_UserOrb radius])
                    {
                        orbA.fillColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:0.4f];
                        orbA.strokeColor = [UIColor greenColor];
                    }
                    else
                    {
                        orbA.fillColor = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:0.4f];
                        orbA.strokeColor = [UIColor redColor];
                    }
                }
            }
        }
    }
    
    //If user orb is too small, set game over to true
    if([m_UserOrb radius]<=ORB_RADIUS_CLICK_AMOUNT)
    {
        [m_GameViewController ShowLoseMenu];
        
    }
    //If the game is not lost, check for winning condition
    else if([m_UserOrb radius]>remainingRadius)
    {
        [m_GameViewController ShowWinMenu];
    }
}

-(void)reset
{
    //Remove all the orbs
    for(OrbNode* orb in m_Orbs)
    {
        [orb removeFromParent];
    }
    
    //Remove all orbs from the array
    [m_Orbs removeAllObjects];
    
    //Set the user orb to nil
    m_UserOrb = nil;

    //Randomize how many orbs will be in the game
    unsigned int numberOfOrbs = MIN_NUMBER_OF_ORBS + arc4random_uniform(MAX_NUMBER_OF_ORBS - MIN_NUMBER_OF_ORBS);
    float maxTotalRadii = fminf(self.view.frame.size.width, self.view.frame.size.height) / 2.4f;
    float totalRadii = 0.0f;

    //Cycle through and spawn the orbs
    for(unsigned int i = 0; i < numberOfOrbs; i++)
    {
        //Randomize the position and angle
        CGPoint position = CGPointMake(arc4random_uniform(self.view.frame.size.width), arc4random_uniform(self.view.frame.size.height));
        float angle = arc4random_uniform(360);
        float radius = i == 0 ? ORB_USER_DEFAULT_RADIUS : ORB_MIN_RADIUS + arc4random_uniform(ORB_MAX_RADIUS - ORB_MIN_RADIUS);
        float speed = i == 0 ? ORB_USER_DEFAULT_SPEED : ORB_MIN_SPEED + arc4random_uniform(ORB_MAX_SPEED - ORB_MIN_SPEED);
        
        //Increment the total orb radii
        totalRadii += radius;
        
        //If the total radii is MORE than the allowed radii then delete
        //the last created orb and break out of the loop
        if(totalRadii >= maxTotalRadii)
        {
            break;
        }
        
        //Spawn a new orb
        OrbNode* orb = [self spawnOrb:position radius:radius angle:angle speed:speed];
        
        //If the first index is zero, then that's the user controlled orb, set the pointer and color to blue
        if(i == 0)
        {
            m_UserOrb = orb;
            m_UserOrb.fillColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.4f];
            m_UserOrb.strokeColor = [UIColor blueColor];
        }
    }
}

-(OrbNode*)spawnOrb:(CGPoint)position radius:(float)radius angle:(float)angle speed:(float)speed
{
    //Create the orb
    OrbNode* orb = [OrbNode shapeNodeWithCircleOfRadius:radius];
    [orb initWithRadius:radius speed:speed angle:angle];
    orb.position = position;
    orb.fillColor = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:0.4f];
    orb.strokeColor = [UIColor greenColor];
    
    //Add the orb to the Scene
    [self addChild:orb];
    
    //Add the orb to the Orbs array
    [m_Orbs addObject:orb];
    
    //Return the orb
    return orb;
}

//Collision detection and handling methods
-(float)calculateOverlap:(OrbNode*)orbA OrbB:(OrbNode*)orbB
{
    //Safety check that both Orb objects are enabled
    if([orbA isPaused] == true || [orbB isPaused] == true)
    {
        return 0.0f;
    }
    
    //Calculate the distance square and the radii squared
    float orbSquaredX = ([orbA position].x - [orbB position].x) * ([orbA position].x - [orbB position].x);
    float orbSquaredY = ([orbA position].y - [orbB position].y) * ([orbA position].y - [orbB position].y);
    float distanceSquared = orbSquaredX + orbSquaredY;
    float radiiSquared = ([orbA radius] + [orbB radius]) * ([orbA radius] + [orbB radius]);

    //Compare the distance to combined radii
    if(radiiSquared > distanceSquared)
    {
        //Return the overlap between the two orb objects
        float distance = sqrtf(distanceSquared);
        float overlap = sqrtf(radiiSquared) - distance;
        return overlap;
    }

    return 0.0f;
}

-(void)handleCollision:(OrbNode*)orbA OrbB:(OrbNode*)orbB Overlap:(float)overlap
{
    float quarterOverlap = overlap / 4.0f;
    if([orbA radius] > [orbB radius])
    {
        if(orbA==m_UserOrb)
            [[AudioManager GetInstance]PlayAbsorbSound];
        float newRadius = fmaxf([orbB radius] - quarterOverlap, 0.0f);
        float radiusLost = [orbB radius] - newRadius;
        [orbB setRadius:newRadius];
        [orbA setRadius:[orbA radius] + radiusLost];
    }
    else
    {
        float newRadius = fmaxf([orbA radius] - quarterOverlap, 0.0f);
        float radiusLost = [orbA radius] - newRadius;
        [orbA setRadius:newRadius];
        [orbB setRadius:[orbB radius] + radiusLost];
    }
}

@end
