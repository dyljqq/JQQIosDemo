//
//  ViewController.h
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView* tableView;

@end

