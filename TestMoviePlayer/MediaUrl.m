//
//  MediaUrl.m
//  TestMoviePlayer
//
//  Created by wsliang on 15/9/11.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import "MediaUrl.h"

@implementation MediaUrl

+(instancetype)sharedObject
{
  static MediaUrl *staticMedialUrl = nil;
  if (!staticMedialUrl) {
    staticMedialUrl = [MediaUrl new];
  }
  return staticMedialUrl;
}


//-(NSURL*)url
//{
//  if (self.isLocalFile) {
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"mp4"];
//    if (filePath) {
//      return [NSURL fileURLWithPath:filePath];
//    }
//    return nil;
//  }
//  
//  return _url;
//}


@end
