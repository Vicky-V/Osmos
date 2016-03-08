//
//  OrbNode.m
//  Assignment1
//
//  Created by Bradley Flood on 2015-01-13.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import "OrbNode.h"

@implementation OrbNode

@synthesize radius = m_Radius;
@synthesize speed = m_Speed;
@synthesize angle = m_Angle;

-(void)initWithRadius:(float)radius speed:(float)speed angle:(float)angle
{
    m_Radius = radius;
    m_Speed = speed;
    m_Angle = angle;
}

-(void)update:(double)delta
{
    //Calculate the orb's velocity based on the speed and the angle
    float velocityX = m_Speed * cosf(m_Angle * TO_RADIANS);
    float velocityY = m_Speed * sinf(m_Angle * TO_RADIANS);

    //Set the orb's x and y position
    CGPoint position = CGPointMake(self.position.x + velocityX * delta, self.position.y + velocityY * delta);
    self.position = position;

    //Get the scene's view frame
    SKScene* scene = (SKScene*)self.parent;
    CGRect viewFrame = scene.view.frame;
    
    //Vertical bounds check
    if(self.position.y - self.radius < viewFrame.origin.y)
    {
        //There was a collision at the top, reverse the y-velocity
        position.y = viewFrame.origin.y + self.radius;
        self.position = position;
        
        //Calculate and set the angle
        m_Angle = atan2f(-velocityY, velocityX) * TO_DEGREES;
        
        //Calculate and set the speed
        m_Speed = sqrtf(velocityX * velocityX + -velocityY * -velocityY);
    }
    else if(self.position.y + self.radius > viewFrame.origin.y + viewFrame.size.height)
    {
        //There was a collision at the top, reverse the y-velocity
        position.y = viewFrame.origin.y + viewFrame.size.height - self.radius;
        self.position = position;
        
        //Calculate and set the angle
        m_Angle = atan2f(-velocityY, velocityX) * TO_DEGREES;
        
        //Calculate and set the speed
        m_Speed = sqrtf(velocityX * velocityX + -velocityY * -velocityY);
    }
    
    //Horizontal bounds check
    if(self.position.x - self.radius < viewFrame.origin.x)
    {
        //There was a collision at the left side, reverse the x-velocity
        position.x = viewFrame.origin.x + self.radius;
        self.position = position;
        
        //Calculate and set the angle
        m_Angle = atan2f(velocityY, -velocityX) * TO_DEGREES;
        
        //Calculate and set the speed
        m_Speed = sqrtf(-velocityX * -velocityX + velocityY * velocityY);
    }
    else if(self.position.x + self.radius > viewFrame.origin.x + viewFrame.size.width)
    {
        //There was a collision at the right side, reverse the x-velocity
        position.x = viewFrame.origin.x + viewFrame.size.width - self.radius;
        self.position = position;
        
        //Calculate and set the angle
        m_Angle = atan2f(velocityY, -velocityX) * TO_DEGREES;
        
        //Calculate and set the speed
        m_Speed = sqrtf(-velocityX * -velocityX + velocityY * velocityY);
    }
}

-(void)setRadius:(float)radius
{
    m_Radius = fmaxf(radius, 0.0f);
    
    if(m_Radius == 0.0f)
    {
        self.hidden = true;
        self.paused = true;
    }
    else
    {
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, nil, 0.0, 0.0, radius, 0.0, 2.0 * M_PI, true);
        self.path = path;
    }
}

@end
