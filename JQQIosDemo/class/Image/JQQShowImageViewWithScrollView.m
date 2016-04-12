//
//  JQQShowImageViewWithScrollView.m
//  IosTest
//
//  Created by 季勤强 on 16/2/1.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "JQQShowImageViewWithScrollView.h"
#import "UIImageView+WebCache.h"

#define WINDOW_WIDTH [UIScreen mainScreen].bounds.size.width
#define WINDOW_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PROGRESSVIEW_WIDTH 40

@interface JQQShowImageViewWithScrollView () <UIScrollViewDelegate>

@end

@implementation JQQShowImageViewWithScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor grayColor];
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 6.0;
        self.delegate = self;
        self.contentSize = CGSizeMake(1280, 960);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)showImageViewAtIndex:(NSArray *)images atIndex:(int)index{
    
    //删除原有的UIImageView
    for (UIView* view in self.subviews) {
        if([view isKindOfClass:[UIImageView class]]){
            [view removeFromSuperview];
        }
    }
    
    float x = 0;
    int n = 0;
    for (id image in images) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, (WINDOW_HEIGHT - WINDOW_WIDTH)/2, WINDOW_WIDTH, WINDOW_WIDTH)];
        if(_isWebImage){
            UIActivityIndicatorView *activityProgressView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((WINDOW_WIDTH - PROGRESSVIEW_WIDTH)/2, (WINDOW_WIDTH - PROGRESSVIEW_WIDTH)/2, PROGRESSVIEW_WIDTH, PROGRESSVIEW_WIDTH)];
            activityProgressView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [imageView addSubview:activityProgressView];
            [activityProgressView startAnimating];
            [imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL){
                if(image){
                    [activityProgressView stopAnimating];
                }
            }];
        }else{
            imageView.image = image;
        }
        [self addSubview:imageView];
        imageView.tag = 8888 + n++;
        x += WINDOW_WIDTH;
    }
    self.contentSize = CGSizeMake(WINDOW_WIDTH * [images count], WINDOW_HEIGHT);
    self.contentOffset = CGPointMake(index * WINDOW_WIDTH, 0);
    [self centerScrollViewContents];
}

#pragma Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [scrollView viewWithTag:8888];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self centerScrollViewContents];
}

#pragma Action

- (void)tapAction:(UITapGestureRecognizer*)tap{
//    CABasicAnimation *animaton = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animaton.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    animaton.duration = 0.3;
//    animaton.fromValue = @1;
//    animaton.toValue = @0.1;
//    animaton.delegate = self;
//    [tap.view.layer addAnimation:animaton forKey:@"JQQScale"];
    [UIView animateWithDuration:0.3 animations:^{
        self.hidden = YES;
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}

#pragma Private Method

- (void)centerScrollViewContents {
    CGSize boundsSize = self.bounds.size;
    UIImageView *imageView = [self viewWithTag:8888];
    CGRect contentsFrame = imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    imageView.frame = contentsFrame;
}

@end
