//
//  GameScene.h
//  Assignment1
//

//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "OrbNode.h"
#import "GameViewController.h"

//Local constants
#define MIN_NUMBER_OF_ORBS 10
#define MAX_NUMBER_OF_ORBS 50
#define ORB_MIN_RADIUS 3
#define ORB_MAX_RADIUS 9
#define ORB_MIN_SPEED 5
#define ORB_MAX_SPEED 40
#define ORB_USER_DEFAULT_RADIUS ORB_MAX_RADIUS
#define ORB_USER_DEFAULT_SPEED 25
#define ORB_SPEED_INCREMENT 15
#define ORB_RADIUS_CLICK_AMOUNT 1

@interface GameScene : SKScene
{
    UIStoryboard* m_Storyboard;
    NSMutableArray* m_Orbs;
    OrbNode* m_UserOrb;
    CFTimeInterval m_LastTimeInterval;
    BOOL m_ShowLoseScreen;
    GameViewController* m_GameViewController;
}

@property(nonatomic,assign) BOOL gameIsLost;

-(void)setViewController:(GameViewController*)gameViewController;

//Reset's the game
-(void)reset;

//Spawn's an orb at the position with a radius, angle and speed
-(OrbNode*)spawnOrb:(CGPoint)position radius:(float)radius angle:(float)angle speed:(float)speed;

//Collision detection and handling methods
-(float)calculateOverlap:(OrbNode*)orbA OrbB:(OrbNode*)orbB;
-(void)handleCollision:(OrbNode*)orbA OrbB:(OrbNode*)orbB Overlap:(float)overlap;

@end
