//
//  OrbNode.h
//  Assignment1
//
//  Created by Bradley Flood on 2015-01-13.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define TO_DEGREES 57.2957795f
#define TO_RADIANS 0.0174532925f


@interface OrbNode : SKShapeNode
{
    float m_Radius;
    float m_Speed;
    float m_Angle;
}

-(void)initWithRadius:(float)radius speed:(float)speed angle:(float)angle;

-(void)update:(double)delta;

@property (nonatomic, assign) float radius;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) float angle;

@end
