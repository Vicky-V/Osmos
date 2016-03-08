//
//  HelpMenuViewController.m
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-01-28.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import "HelpMenuViewController.h"

@interface HelpMenuViewController ()

@end

@implementation HelpMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Do any additional setup after loading the view.
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
