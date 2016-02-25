//
//  TransitionController.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/25.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "TransitionController.h"
#import "TransitionAnimation.h"
#import "MenuController.h"

@implementation TransitionController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"转场动画";
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 50;
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma Delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if(operation == UINavigationControllerOperationPush){
        TransitionAnimation* transition = [[TransitionAnimation alloc] initWithClickedViewFrame:CGRectMake(100, 100, 100, 100)];
        return transition;
    }
    return nil;
}

#pragma ACTION

- (void)buttonAction{
    MenuController* menu = [MenuController new];
    [self.navigationController pushViewController:menu animated:YES];
}

@end
