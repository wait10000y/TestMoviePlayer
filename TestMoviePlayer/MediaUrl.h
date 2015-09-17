//
//  MediaUrl.h
//  TestMoviePlayer
//
//  Created by wsliang on 15/9/11.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaUrl : NSObject
@property (nonatomic) BOOL isLocalFile;

@property (nonatomic) NSURL *url;

+(instancetype)sharedObject;

@end
