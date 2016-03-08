//
//  AudioManager.h
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-02-01.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioManager : NSObject
{
    NSString* m_CurrentMusicPath;
    float m_MusicVolume;
    float m_SFXVolume;
}

+(AudioManager*) GetInstance;

-(void) InitMusic:(NSString*)path;
-(void)InitSounds;
-(void)UpdateVolumes;
-(void)PlayTouchSound;
-(void)PlayAbsorbSound;

@property (nonatomic, assign) float musicVolume;
@property (nonatomic, assign) float SFXVolume;

@end
