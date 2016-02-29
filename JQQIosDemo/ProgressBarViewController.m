//
//  ProgressBarViewController.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/29.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "ProgressBarViewController.h"
#import "JQQProgressBar.h"

@interface ProgressBarViewController ()

@end

@implementation ProgressBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ProgressBar";
    self.view.backgroundColor = [UIColor whiteColor];
    
    JQQProgressBar* progressBar = [[JQQProgressBar alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:progressBar];
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
