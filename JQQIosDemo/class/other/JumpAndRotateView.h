//
//  JumpAndRotateView.h
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/26.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 实现思路：
 这个动画分成了上升和下降两个过程，上升时改变的是y值与rotation的值，下降的时候也一样，角度一共改变180度，所以用组合动画即可以实现。
 小细节是动画中增加了一个可以放大和缩小的阴影，做交互的细节非常的重要，借鉴的别人思想。
 **/

typedef enum : NSUInteger {
    JUMP_UP_STATE,
    JUMP_DOWN_STATE,
} STATE;

@interface JumpAndRotateView : UIView

//上升时的图片
@property (nonatomic, strong)UIImage* startImage;

//下降的图片
@property (nonatomic, strong)UIImage* endImage;

@property(nonatomic, assign)STATE state;

//开始动画
- (void)jumpUp;

@end
