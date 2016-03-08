//
//  GameViewController.m
//  Assignment1
//
//  Created by Bradley Flood on 2015-01-13.
//  Copyright (c) 2015 Algonquin College. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "AudioManager.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file
{
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

@synthesize pauseView=m_PauseView;
@synthesize loseView=m_LoseView;
@synthesize winView=m_WinView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setup storyboard pointer
    m_Storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //Setup path for the main menu music file
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource: @"recording2" ofType: @"wav"];
        
    //Start music via Audio Manager
    [[AudioManager GetInstance] InitMusic:soundFilePath];
    
    //Init sounds
    [[AudioManager GetInstance] InitSounds];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    m_Game = [GameScene unarchiveFromFile:@"GameScene"];
    m_Game.scaleMode = SKSceneScaleModeResizeFill;
    
    //Pass a pointer to this view controller to scene
    [m_Game setViewController:self];		
    
    // Present the scene.
    [skView presentScene:m_Game];
}

- (void)ShowLoseMenu
{
    //Show Lose Screen
    m_PauseView.hidden=YES;
    m_LoseView.hidden=NO;
    m_WinView.hidden=YES;
    
    //Pause the game
    SKView* skView=(SKView*)self.view;
    skView.paused=YES;

}
- (void)ShowWinMenu
{
    //Show Win Screen
    m_PauseView.hidden=YES;
    m_LoseView.hidden=YES;
    m_WinView.hidden=NO;
    
    //Pause the game
    SKView* skView=(SKView*)self.view;
    skView.paused=YES;
    
}

-(IBAction)pauseAction:(id)sender
{
    //Show the pause view
    m_PauseView.hidden=NO;
    
    //Pause the game
    SKView* skView=(SKView*)self.view;
    skView.paused=YES;
}

-(IBAction)resumeAction:(id)sender
{
    //Hide the pause view
    m_PauseView.hidden=YES;
    
    //Resume the game
    SKView* skView=(SKView*)self.view;
    skView.paused=NO;
}

-(IBAction)resetAction:(id)sender
{
    //Hide the pause view
    m_PauseView.hidden=YES;
    m_LoseView.hidden=YES;
    m_WinView.hidden=YES;
    
    //Resume the game
    SKView* skView=(SKView*)self.view;
    skView.paused=NO;
    
    //Restart the game
    [m_Game reset];
    
}

-(IBAction)backToMenuAction:(id)sender
{
    //Restart the game
    [m_Game reset];
    
    //Pause the game
    SKView* skView=(SKView*)self.view;
    skView.paused=YES;
    
    UIViewController* vc=[m_Storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:vc animated:NO completion:nil];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
