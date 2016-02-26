//
//  JumpAndRotateView.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/26.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "JumpAndRotateView.h"

#define jumpUpDuration 0.125
#define jumpDownDuration 0.215

@interface JumpAndRotateView ()

@property (nonatomic, strong)UIImageView* jumpImageView;

@property (nonatomic, strong)UIImageView* shadowView;

@end

@implementation JumpAndRotateView{
    BOOL animating;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.jumpImageView];
        [self addSubview:self.shadowView];
    }
    return self;
}

- (void)setState:(STATE)state{
    _state = state;
    self.jumpImageView.image = state == JUMP_UP_STATE ? self.startImage : self.endImage;
}

- (void)jumpUp{
    
    if(animating)
        return ;
    
    animating = YES;
    
    CABasicAnimation* rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI_2);
    rotateAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation* positionAnim = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnim.fromValue = @(self.jumpImageView.center.y);
    positionAnim.toValue = @(self.jumpImageView.center.y - 14);
    positionAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.delegate = self;
    group.duration = jumpUpDuration;
    group.fillMode = kCAFillModeForwards;//当动画结束后,layer会一直保持着动画最后的状态
    group.removedOnCompletion = NO;
    group.animations = @[rotateAnim, positionAnim];
    
    [self.jumpImageView.layer addAnimation:group forKey:@"jumpUp"];
}

- (void)animationDidStart:(CAAnimation *)anim{
    if([anim isEqual:[self.jumpImageView.layer animationForKey:@"jumpUp"]]){
        [UIView animateWithDuration:jumpUpDuration animations:^{
            self.shadowView.bounds = CGRectMake(0, 0, self.shadowView.bounds.size.width * 1.6, self.shadowView.bounds.size.height);
            self.shadowView.alpha = 0.2;
        }];
    }else if([anim isEqual:[self.jumpImageView.layer animationForKey:@"jumpDown"]]){
        [UIView animateWithDuration:jumpDownDuration animations:^{
            self.shadowView.bounds = CGRectMake(0, 0, self.shadowView.bounds.size.width / 1.6, self.shadowView.bounds.size.height);
            self.shadowView.alpha = 0.4;
        }];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if([anim isEqual:[self.jumpImageView.layer animationForKey:@"jumpUp"]]){
        
        self.state = self.state == JUMP_UP_STATE ? JUMP_DOWN_STATE : JUMP_UP_STATE;
        
        CABasicAnimation* rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        rotateAnim.fromValue = @(M_PI_2);
        rotateAnim.toValue = @(M_PI);
        rotateAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        CABasicAnimation* positionAnim = [CABasicAnimation animationWithKeyPath:@"position.y"];
        positionAnim.fromValue = @(self.jumpImageView.center.y - 14);
        positionAnim.toValue = @(self.jumpImageView.center.y);
        positionAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup* group = [CAAnimationGroup animation];
        group.delegate = self;
        group.fillMode = kCAFillModeForwards;
        group.removedOnCompletion = NO;
        group.duration = jumpDownDuration;
        group.animations = @[rotateAnim, positionAnim];
        
        [self.jumpImageView.layer addAnimation:group forKey:@"jumpDown"];
    }else{
        [self.jumpImageView.layer removeAllAnimations];
        animating = NO;
    }
}


#pragma Private Method

- (UIImageView *)jumpImageView{
    if(_jumpImageView == nil){
        _jumpImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, self.bounds.size.width - 6, self.bounds.size.height - 6)];
        _jumpImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _jumpImageView;
}

- (UIImageView *)shadowView{
    if(_shadowView == nil){
        _shadowView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 10)/2, self.bounds.size.height - 3, 10, 3)];
        _shadowView.image = [UIImage imageNamed:@"shadow_new"];
        _shadowView.alpha = 0.4;
    }
    return _shadowView;
}

@end
