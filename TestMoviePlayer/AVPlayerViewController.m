//
//  AVPlayerViewController.m
//  TestMoviePlayer
//
//  Created by wsliang on 15/9/11.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "AVPlayerViewController.h"
#import "MediaUrl.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerViewController ()

@end

@implementation AVPlayerViewController
{
  AVPlayer *player;
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
    if (player.status == AVPlayerStatusReadyToPlay) {
      [player pause];
    }
    player = nil;
  }
}

-(AVPlayer*)playMovieWithUrl:(NSURL*)theUrl forView:(UIView*)theView
{
  if (theUrl) {
    AVAsset *movieAsset	= [AVURLAsset URLAssetWithURL:theUrl options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = theView.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [theView.layer addSublayer:playerLayer];
    [player play];
    
    return player;
  }else{
    NSLog(@"------- no file --------");
  }
  return nil;
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
