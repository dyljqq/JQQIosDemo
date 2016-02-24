//
//  LoopScrollViewController.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "LoopScrollViewController.h"
#import "LoopScrollView.h"

@implementation LoopScrollViewController{
    LoopScrollView* loopView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"LoopScrollView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    loopView = [[LoopScrollView alloc] initWithFrame:CGRectMake(0, 100, 200, 44 * 3)];
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < 16; i++) {
        NSString* str = [NSString stringWithFormat:@"jqq gain price %d", i];
        [array addObject:str];
    }
    [loopView updateView:[array copy]];
    [self.view addSubview:loopView];
}

@end
