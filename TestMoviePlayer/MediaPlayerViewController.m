//
//  MediaPlayerViewController.m
//  TestMoviePlayer
//
//  Created by wsliang on 15/9/11.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MediaUrl.h"

@interface MediaPlayerViewController ()

@end

@implementation MediaPlayerViewController
{
  MPMoviePlayerController *player;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self playMovieWithUrl:[MediaUrl sharedObject].url forView:self.viewForMovie];
}

-(void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  if (player) {
    if (player.playbackState != MPMoviePlaybackStateStopped) {
      [player stop];
    }
    player = nil;
  }
}

-(MPMoviePlayerController*)playMovieWithUrl:(NSURL*)theUrl forView:(UIView*)theView
{
  if (theUrl) {
    player = [[MPMoviePlayerController alloc] initWithContentURL:theUrl];
    
    player.controlStyle = MPMovieControlStyleDefault;
    player.view.frame = theView.bounds;
    NSLog(@"------------ MPMoviePlayerController view: %@ ----------------",NSStringFromCGRect(player.view.frame));
    //  player.shouldAutoplay = YES;
    //  player.repeatMode = MPMovieRepeatModeOne;
    //  player.scalingMode = MPMovieScalingModeAspectFit;
    
    [theView addSubview:player.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStatusChanged:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:player];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStoped:) name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerLoadStateDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
      MPMoviePlayerController *tPlayer = note.object;
      NSLog(@"------- NSNotification : %@ ----------",[self stringForPlayerState:tPlayer.playbackState]);
    }];
    
    [player prepareToPlay];
    [player play];
    return player;
  }else{
    NSLog(@"------- no file --------");
  }
  return nil;
}

-(void)playStatusChanged:(NSNotification*)sender
{
  MPMoviePlayerController *tPlayer = sender.object;
  NSLog(@"------- playStatusChanged : %@ ----------",[self stringForPlayerState:tPlayer.playbackState]);
}

-(void)playStoped:(id)sender
{
  NSLog(@"------- playStoped : %@ ----------",sender);
}

-(NSString*)stringForPlayerState:(MPMoviePlaybackState)theState
{
  NSString *rStr = @"unknown";
  switch (theState) {
    case MPMoviePlaybackStateStopped:
    {
      rStr = @"Stopped";
    } break;
    case MPMoviePlaybackStateSeekingBackward:
    {
      rStr = @"SeekingBackward";
    } break;
    case MPMoviePlaybackStateSeekingForward:
    {
      rStr = @"SeekingForward";
    } break;
    case MPMoviePlaybackStatePlaying:
    {
      rStr = @"Playing";
    } break;
    case MPMoviePlaybackStatePaused:
    {
      rStr = @"Paused";
    } break;
    case MPMoviePlaybackStateInterrupted:
    {
      rStr = @"Interrupted";
    } break;
      
    default:
      break;
  }
  return rStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
