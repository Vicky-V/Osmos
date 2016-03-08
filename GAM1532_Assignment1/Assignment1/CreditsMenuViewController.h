//
//  CreditsMenuViewController.h
//  Assignment1
//
//  Created by Viktoriya Voinova on 2015-01-28.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreditsMenuViewController : UIViewController
{
    UIStoryboard* sb;
    UILabel* m_Version;
}

@property(nonatomic, strong) IBOutlet UILabel* versionNumber;

-(IBAction)backButtonAction:(id)sender;

@end
