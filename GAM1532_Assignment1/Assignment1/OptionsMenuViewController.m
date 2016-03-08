//
//  OptionsMenuViewController.m
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-01-28.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import "OptionsMenuViewController.h"
#import "AudioManager.h"

@interface OptionsMenuViewController ()

@end

@implementation OptionsMenuViewController

@synthesize musicSlider=m_MusicSlider;
@synthesize SFXSlider=m_SFXSlider;


- (void)viewDidLoad {
    [super viewDidLoad];
    sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Do any additional setup after loading the view.
    
    //Set sliders' values according to the current volume levels
    [m_MusicSlider setValue:[[AudioManager GetInstance] musicVolume]/2 animated:YES];
    [m_SFXSlider setValue:[[AudioManager GetInstance] SFXVolume]/2 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backButtonAction:(id)sender
{
    UIViewController* vc=[sb instantiateViewControllerWithIdentifier:@"MainMenu"];
    vc.modalPresentationStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)MusicVolumeSlider:(UISlider *)sender {
    float value = [sender value];
    
    //Pass value to Audio Manager
    [AudioManager GetInstance].musicVolume=value;
    [[AudioManager GetInstance]UpdateVolumes];
    
}

- (IBAction)SFXVolumeSlider:(UISlider *)sender {
    float value = [sender value];
    
    //Pass value to Audio Manager
    [AudioManager GetInstance].SFXVolume=value;
    [[AudioManager GetInstance]UpdateVolumes];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
