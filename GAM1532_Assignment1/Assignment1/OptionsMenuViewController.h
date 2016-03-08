//
//  OptionsMenuViewController.h
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-01-28.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionsMenuViewController : UIViewController
{
    UIStoryboard* sb;
    UISlider* m_MusicSlider;
    UISlider* m_SFXSlider;
}

@property(nonatomic, strong) IBOutlet UISlider* musicSlider;
@property(nonatomic, strong) IBOutlet UISlider* SFXSlider;

-(IBAction)backButtonAction:(id)sender;
- (IBAction)MusicVolumeSlider:(UISlider *)sender;
- (IBAction)SFXVolumeSlider:(UISlider *)sender;

@end
