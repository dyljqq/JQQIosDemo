//
//  TransitionAnimation.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/25.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "TransitionAnimation.h"

static const CGFloat DURATION = 0.7;

@interface TransitionAnimation ()

@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation TransitionAnimation{
    CGRect clickedFrame;
}

- (instancetype)initWithClickedViewFrame:(CGRect)frame{
    self = [super init];
    if(self){
        clickedFrame = frame;
    }
    return self;
}

#pragma Delegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIViewController* fromController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* toController = (UIViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView* containerView = [transitionContext containerView];
    
    UIBezierPath* startPath = [UIBezierPath bezierPathWithOvalInRect:clickedFrame];
    [containerView addSubview:fromController.view];
    [containerView addSubview:toController.view];
    
    CGPoint endPoint, center = CGPointMake((clickedFrame.origin.x + clickedFrame.size.width)/2, (clickedFrame.origin.y + clickedFrame.size.height)/2);
    //通过判断clickedFrame所在的象限来确定覆盖整个view的最小的圆的半径
    if(clickedFrame.origin.x > toController.view.bounds.size.width/2){
        if(clickedFrame.origin.y < toController.view.bounds.size.height/2){
            //第一象限
            endPoint = CGPointMake(center.x, center.y - toController.view.frame.size.height + 30);
        }else{
            //第四象限
            endPoint = CGPointMake(center.x, center.y);
        }
    }else{
        if(clickedFrame.origin.y < toController.view.bounds.size.height/2){
            //第二象限
            endPoint = CGPointMake(center.x - toController.view.bounds.size.width, center.y - toController.view.frame.size.height + 30);
        }else{
            //第三象限
            endPoint = CGPointMake(center.x - toController.view.bounds.size.width, center.y);
        }
    }
    CGFloat radius = sqrt(endPoint.x * endPoint.x + endPoint.y * endPoint.y);
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(clickedFrame, -radius, -radius)];
    
    //创建CAShapeLayer负责展示遮盖层
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    toController.view.layer.mask = maskLayer;
    
    CABasicAnimation* basic = [CABasicAnimation animationWithKeyPath:@"path"];
    basic.duration = DURATION;
    basic.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    basic.toValue = (__bridge id _Nullable)(maskPath.CGPath);
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basic.delegate = self;
    [maskLayer addAnimation:basic forKey:@"path"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //transition已完成，必须说明
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
