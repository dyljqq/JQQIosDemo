//
//  SlideMenu.h
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SlideMenuButtonClickedBlock)(NSInteger buttonIndex);

@interface SlideMenu : UIView

@property (nonatomic, strong)SlideMenuButtonClickedBlock buttonClickedBlock;

- (instancetype)initWithTitles:(NSArray*)titles;

/**
 to trigger the menu
 **/
- (void)trigger;

@end
