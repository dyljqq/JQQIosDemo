//
//  TransitionAnimation.h
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/25.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

- (instancetype)initWithClickedViewFrame:(CGRect)frame;

@end
