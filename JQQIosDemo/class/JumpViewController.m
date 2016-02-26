//
//  JumpViewController.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/26.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "JumpViewController.h"
#import "JumpAndRotateView.h"

@interface JumpViewController ()

@end

@implementation JumpViewController{
    JumpAndRotateView* jumpView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"跳跃动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    jumpView = [[JumpAndRotateView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 20)/2, 150, 20, 26)];
    jumpView.startImage = [UIImage imageNamed:@"icon_star_incell"];
    jumpView.endImage = [UIImage imageNamed:@"blue_dot"];
    jumpView.state = JUMP_UP_STATE;
    [self.view addSubview:jumpView];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100)/2, 200, 100, 50)];
    [button setTitle:@"Jump!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)jumpAction{
    [jumpView jumpUp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
