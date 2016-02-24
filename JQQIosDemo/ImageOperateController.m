//
//  ImageOperateController.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "ImageOperateController.h"
#import "JQQShowImageViewWithScrollView.h"
#import "AppDelegate.h"

#define APPLICATION_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

@implementation ImageOperateController{
    JQQShowImageViewWithScrollView* showImageView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"Image Operate";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image = [UIImage imageNamed:@"jqq.jpg"];
    [self.view addSubview:imageView];
    
    showImageView = [[JQQShowImageViewWithScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    showImageView.hidden = YES;
    [APPLICATION_DELEGATE.window addSubview:showImageView];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [imageView addGestureRecognizer:tap];
    imageView.userInteractionEnabled = YES;
}

- (void)tapAction:(UITapGestureRecognizer*)tap{
    UIImageView* imageView = (UIImageView*)tap.view;
    [showImageView showImageViewAtIndex:@[imageView.image] atIndex:0];
    showImageView.hidden = NO;
}

@end
