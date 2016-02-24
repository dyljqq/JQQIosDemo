//
//  JQQShowImageViewWithScrollView.h
//  IosTest
//
//  Created by 季勤强 on 16/2/1.
//  Copyright © 2016年 季勤强. All rights reserved.
//

/**
 单击图片放大，如果有多张图片，可滑动展示
 **/

#import <UIKit/UIKit.h>

@interface JQQShowImageViewWithScrollView : UIScrollView

//判断传入的值是url还是image
@property (nonatomic)BOOL isWebImage;

//展示指定位置的图片,index是表示需要最先显示哪张图
- (void)showImageViewAtIndex:(NSArray*)images atIndex:(int)index;

@end
