//
//  ViewController.h
//  TestMoviePlayer
//
//  Created by wsliang on 15/9/11.
//  Copyright (c) 2015年 wsliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textUrl;
- (IBAction)actionPlayMovies:(UIButton *)sender;

@end
