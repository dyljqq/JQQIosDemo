//
//  JQQProgressBar.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/29.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "JQQProgressBar.h"

#define PROGRESS_BAR_HEIGHT 40

@implementation JQQProgressBar{
    int progressBarWidth;
    CGRect originFrame;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame{
    originFrame = frame;
    self.backgroundColor = [UIColor blueColor];
    self.layer.cornerRadius = frame.size.height/2;
    self.layer.masksToBounds = YES;
    progressBarWidth = frame.size.width;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer*)tap{
    
    for (CALayer* subLayer in self.layer.sublayers) {
        [subLayer removeFromSuperlayer];
    }
    
    self.backgroundColor = [UIColor colorWithRed:0.0 green:122/255.0 blue:255/255.0 alpha:1.0];
    
    //layer有两个状态，presentationLayer以及modalLayer，默认情况是改变了layer后会变回原来的modelLayer状态，所以需要先显示的改变他的layer
    self.layer.cornerRadius = PROGRESS_BAR_HEIGHT/2;
    CABasicAnimation* basic = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    basic.duration = 0.2;
    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    basic.fromValue = @(self.frame.size.height/2);
    basic.delegate = self;
    [self.layer addAnimation:basic forKey:@"CornerRadiusAnim"];
}

#pragma Delegate

- (void)animationDidStart:(CAAnimation *)anim{
    if([anim isEqual:[self.layer animationForKey:@"CornerRadiusAnim"]]){
        [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.layer.bounds = CGRectMake(0, 0, progressBarWidth, PROGRESS_BAR_HEIGHT);
        }completion:^(BOOL finished){
            [self.layer removeAllAnimations];
            [self progressBarAnim];
        }];
    }else if([anim isEqual:[self.layer animationForKey:@"cornerRadiusExpandAnim"]]){
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backgroundColor = [UIColor colorWithRed:0.1803921568627451 green:0.8 blue:0.44313725490196076 alpha:1.0];
            self.bounds = CGRectMake(0, 0, originFrame.size.width, originFrame.size.height);
        }completion:^(BOOL finish){
            [self.layer removeAllAnimations];
            [self checkAnimation];
        }];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"progressBarAnimation"]){
        [UIView animateWithDuration:0.3 animations:^{
            for (CALayer *subLayer in self.layer.sublayers) {
                subLayer.opacity = 0.0f;
            }
        } completion:^(BOOL finished) {
            if (finished) {
                for (CALayer *subLayer in self.layer.sublayers) {
                    [subLayer removeFromSuperlayer];
                }
                self.layer.cornerRadius = originFrame.size.height/2;
                CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
                radiusAnimation.duration = 0.2f;
                radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                radiusAnimation.fromValue = @(PROGRESS_BAR_HEIGHT/2);
                radiusAnimation.delegate = self;
                [self.layer addAnimation:radiusAnimation forKey:@"cornerRadiusExpandAnim"];
            }
        }];
    }
}
#pragma Private Method

- (void)progressBarAnim{
    
    CAShapeLayer* layer = [CAShapeLayer layer];
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(PROGRESS_BAR_HEIGHT/2, self.bounds.size.height/2)];
    [path addLineToPoint:CGPointMake(progressBarWidth - PROGRESS_BAR_HEIGHT/2 , PROGRESS_BAR_HEIGHT/2)];
    
    layer.path = path.CGPath;
    layer.lineWidth = PROGRESS_BAR_HEIGHT - 6;
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation* basic = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basic.duration = 2.0f;
    basic.fromValue = @(0.0f);
    basic.toValue = @(1.0f);
    basic.delegate = self;
    [basic setValue:@"progressBarAnimation" forKey:@"animationName"];
    [layer addAnimation:basic forKey:nil];
}

-(void)checkAnimation{
    
    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect rectInCircle = CGRectInset(self.bounds, self.bounds.size.width*(1-1/sqrt(2.0))/2, self.bounds.size.width*(1-1/sqrt(2.0))/2);
    [path moveToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/9, rectInCircle.origin.y + rectInCircle.size.height*2/3)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width/3,rectInCircle.origin.y + rectInCircle.size.height*9/10)];
    [path addLineToPoint:CGPointMake(rectInCircle.origin.x + rectInCircle.size.width*8/10, rectInCircle.origin.y + rectInCircle.size.height*2/10)];
    
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = [UIColor whiteColor].CGColor;
    checkLayer.lineWidth = 10.0;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:checkLayer];
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = 0.3f;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    checkAnimation.delegate = self;
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
    
}

@end
