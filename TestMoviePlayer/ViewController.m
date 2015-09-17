//
//  ViewController.m
//  TestMoviePlayer
//
//  Created by wsliang on 15/9/11.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "ViewController.h"
#import "MediaUrl.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

  self.textUrl.enabled = NO;
  self.textUrl.text = @"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8";
  [self setUrlValue:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self setUrlValue:!self.textUrl.enabled];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
  BOOL isLocal = (sender.selectedSegmentIndex == 0);
  self.textUrl.enabled = !isLocal;
  [self setUrlValue:isLocal];
}

-(void)setUrlValue:(BOOL)forLocal
{
   [MediaUrl sharedObject].isLocalFile = forLocal;
  if (forLocal) {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"mp4"];
    if (filePath) {
      [MediaUrl sharedObject].url = [NSURL fileURLWithPath:filePath];
    }
  }else{
    NSString *filePath = self.textUrl.text;
    if (filePath.length>0) {
      [MediaUrl sharedObject].url = [NSURL URLWithString:filePath];
    }
  }
}


- (IBAction)actionPlayMovies:(UIButton *)sender {
  if (sender.tag == 102) { // play movie
    
    NSURL *movieUrl = [MediaUrl sharedObject].url;
    if (movieUrl) {
      [self presentMoviePlayerViewControllerAnimated:[self createPlayerWithUrl:movieUrl]];
    }else{
      NSLog(@"------- no file --------");
    }
  }
}

-(MPMoviePlayerViewController*)createPlayerWithUrl:(NSURL*)theUrl
{
  MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:theUrl];
  
  return player;
}

@end
