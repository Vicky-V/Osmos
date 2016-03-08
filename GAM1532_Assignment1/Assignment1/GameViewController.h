//
//  GameViewController.h
//  Assignment1
//

//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@class GameScene;

@interface GameViewController : UIViewController
{
    UIStoryboard* m_Storyboard;
    UIView* m_PauseView;
    UIView* m_LoseView;
    UIView* m_WinView;
    GameScene* m_Game;
}
@property (nonatomic, strong) IBOutlet UIView* pauseView;
@property (nonatomic, strong) IBOutlet UIView* loseView;
@property (nonatomic, strong) IBOutlet UIView* winView;

- (void)ShowLoseMenu;
- (void)ShowWinMenu;

-(IBAction)pauseAction:(id)sender;
-(IBAction)resumeAction:(id)sender;
-(IBAction)resetAction:(id)sender;

-(IBAction)backToMenuAction:(id)sender;

@end
