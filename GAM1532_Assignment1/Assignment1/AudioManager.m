//
//  AudioManager.m
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-02-01.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import "AudioManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioManager


static AudioManager* m_Instance=nil;
static AVAudioPlayer* m_MusicPlayer=nil;
static AVAudioPlayer* m_TouchSound=nil;
static AVAudioPlayer* m_AbsorbSound=nil;

@synthesize musicVolume=m_MusicVolume;
@synthesize SFXVolume=m_SFXVolume;

+(AudioManager*)GetInstance
{
    if(m_Instance==nil)
    {
        m_Instance=[[self alloc]init];
        [AudioManager GetInstance].musicVolume=1;
        [AudioManager GetInstance].SFXVolume=1;
                
    }
    return m_Instance;
}


-(void)InitMusic:(NSString*) path
{
    
    if([m_CurrentMusicPath isEqualToString:path]==NO)
    {
        m_CurrentMusicPath=path;
        
        [m_Instance StartMusic];
    }
    
    
}
-(void)InitSounds
{
    //=====SETUP TOUCH SOUND=====
    
    //Setup path for the sound file
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"sound_touch" ofType: @"wav"];
    
    //Setup error & url objects
    NSError* error;
    NSURL *url = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    //Init sound player
    m_TouchSound=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    //Check for errors
    if(m_TouchSound==nil)
        NSLog(@"Sound Error!");
    else
    {
        m_TouchSound.numberOfLoops=1;
    }
    
    //=====SETUP ABSORB SOUND=====
    
    //Setup path for the sound file
    soundFilePath = [[NSBundle mainBundle] pathForResource: @"sound_absorb" ofType: @"wav"];
    
    //Setup url
    url = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    //Init sound player
    m_AbsorbSound=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    //Check for errors
    if(m_AbsorbSound==nil)
        NSLog(@"Sound Error!");
    else
    {
        m_AbsorbSound.numberOfLoops=1;
    }

}

-(void)UpdateVolumes
{
    m_MusicPlayer.volume=m_MusicVolume*2;
    m_TouchSound.volume=m_SFXVolume*2;
    m_AbsorbSound.volume=m_SFXVolume*2;
}

-(void)PlayTouchSound
{
    [m_Instance UpdateVolumes];
    [m_TouchSound play];
}

-(void)PlayAbsorbSound
{
    [m_Instance UpdateVolumes];
    [m_AbsorbSound play];
}

-(void)StartMusic
{
     NSError* error;
    
    if(m_MusicPlayer==nil)
    {
        NSURL *url = [[NSURL alloc] initFileURLWithPath: m_CurrentMusicPath];
        m_MusicPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if(m_MusicPlayer==nil)
            NSLog(@"Music Error!");
        else
        {
            [m_Instance UpdateVolumes];
            [m_MusicPlayer play];
            m_MusicPlayer.numberOfLoops=-1;
        }
    }
    else if(m_MusicPlayer.isPlaying == YES)
    {
        [m_MusicPlayer stop];
        NSURL *url = [[NSURL alloc] initFileURLWithPath: m_CurrentMusicPath];
        m_MusicPlayer=[m_MusicPlayer initWithContentsOfURL:url error:&error];
        
        if(m_MusicPlayer==nil)
            NSLog(@"Music Error!");
        else
        {
            [m_Instance UpdateVolumes];
            [m_MusicPlayer play];
            m_MusicPlayer.numberOfLoops=-1;
        }
    }
}


@end
