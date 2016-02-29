//
//  ViewController.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "ViewController.h"
#import "MenuController.h"
#import "ImageOperateController.h"
#import "LoopScrollViewController.h"
#import "TransitionController.h"
#import "JumpViewController.h"
#import "ProgressBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray* dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Weidget";
    
    dataArray = @[@"Menu", @"ImageOperate", @"LoopScrollView", @"TransitionAnimation", @"JumpAnimation", @"ProgressBar"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

#pragma Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id controller = nil;
    switch (indexPath.row) {
        case 0:
            controller = [MenuController new];
            break;
            
        case 1:
            controller = [ImageOperateController new];
            break;
            
        case 2:
            controller = [LoopScrollViewController new];
            break;
            
        case 3:
            controller = [TransitionController new];
            break;
            
        case 4:
            controller = [JumpViewController new];
            break;
            
        case 5:
            controller = [ProgressBarViewController new];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma Private Method

- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
