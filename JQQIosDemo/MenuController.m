//
//  MenuController.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "MenuController.h"
#import "SlideMenu.h"

@implementation MenuController{
    SlideMenu* slideMenu;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"Menu";
    self.view.backgroundColor = [UIColor whiteColor];
    
    slideMenu = [[SlideMenu alloc] initWithTitles:@[@"首页", @"消息", @"发布"]];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"triggle" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button addTarget:self action:@selector(triggleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)triggleAction{
    [slideMenu trigger];
}

@end
