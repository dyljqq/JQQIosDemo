//
//  MenuButton.h
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MenuButtonClickedBlock)();

@interface MenuButton : UIView

/*
 set your button color, default is white color
 */
@property (nonatomic, strong)UIColor* buttonColor;

/**
 display button click event
 **/
@property (nonatomic, strong)MenuButtonClickedBlock clickedBlock;

/**
 * init method
 **/
- (instancetype)initWithTitle:(NSString*)title;

@end
