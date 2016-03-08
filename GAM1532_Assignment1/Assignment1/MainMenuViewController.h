//
//  MainMenuViewController.h
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-01-28.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MainMenuViewController : UIViewController
{
    UIStoryboard* m_Storyboard;
    AVAudioPlayer* audioPlayer;
}


-(IBAction)startButtonAction:(id)sender;
-(IBAction)optionsButtonAction:(id)sender;
-(IBAction)helpButtonAction:(id)sender;
-(IBAction)creditsButtonAction:(id)sender;

@end
