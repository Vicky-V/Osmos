//
//  MainMenuViewController.m
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-01-28.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AudioManager.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    m_Storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Setup path for the main menu music file
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"recording1" ofType: @"wav"];
    
    //Start music via Audio Manager
    [[AudioManager GetInstance] InitMusic:soundFilePath];
    
                
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startButtonAction:(id)sender
{
    UIViewController* vc=[m_Storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    vc.modalPresentationStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)optionsButtonAction:(id)sender
{
    UIViewController* vc=[m_Storyboard instantiateViewControllerWithIdentifier:@"OptionsMenu"];
    vc.modalPresentationStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];

}

-(IBAction)helpButtonAction:(id)sender
{
    UIViewController* vc=[m_Storyboard instantiateViewControllerWithIdentifier:@"HelpMenu"];
    vc.modalPresentationStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];

}

-(IBAction)creditsButtonAction:(id)sender
{
    UIViewController* vc=[m_Storyboard instantiateViewControllerWithIdentifier:@"CreditsMenu"];
    vc.modalPresentationStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];

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
