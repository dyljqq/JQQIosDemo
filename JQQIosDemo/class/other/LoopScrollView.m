//
//  LoopScrollView.m
//  DianDianYing
//
//  Created by 季勤强 on 16/1/20.
//  Copyright © 2016年 翟玉磊. All rights reserved.
//

#import "LoopScrollView.h"

static const float CELL_HEIGHT = 44.0;//cell高度
static const int CELL_NUM = 4;//显示cell数量

@interface LoopScrollView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView* tableView;

@end

@implementation LoopScrollView{
    NSMutableArray* items;
    NSMutableArray* dataArray;
    NSTimer* timer;
    int currentPosition;//当前数组位置
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame{
    self.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = frame;
    [self addSubview:self.tableView];
}

- (void)updateView:(NSArray*)array{
    items = [array mutableCopy];
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
    dataArray = [NSMutableArray array];
    for (int i = currentPosition; i < CELL_NUM; i++) {
        [dataArray addObject:items[i]];
    }
    [self.tableView reloadData];
    [self addAnimation];
}

#pragma Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = dataArray[indexPath.row];
    return cell;
}

#pragma Action
- (void)scrollAction{
    currentPosition++;
    if(currentPosition >= [items count]){
        currentPosition = 0;
        [dataArray replaceObjectsInRange:NSMakeRange(0, CELL_NUM) withObjectsFromArray:items range:NSMakeRange(currentPosition, CELL_NUM)];
    }else{
        if(currentPosition + CELL_NUM > [items count]){
            NSInteger diff = currentPosition + CELL_NUM - [items count];
            [dataArray replaceObjectsInRange:NSMakeRange(0, CELL_NUM - diff) withObjectsFromArray:items range:NSMakeRange(currentPosition, CELL_NUM - diff)];
            [dataArray replaceObjectsInRange:NSMakeRange(CELL_NUM - diff, diff) withObjectsFromArray:items range:NSMakeRange(0, diff)];
        }else{
            [dataArray replaceObjectsInRange:NSMakeRange(0, CELL_NUM) withObjectsFromArray:items range:NSMakeRange(currentPosition, CELL_NUM)];
        }
    }
    [self addAnimation];
}

#pragma Private Method
- (UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}

- (UIView*)addView:(CGRect)frame setContent:(NSString*)content{
    UIView* view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, APPLICATION_SIZE.width - 30, 20)];
    label.text = content;
    label.textColor = FONT_COLOR;
    label.font = Font(15);
    [view addSubview:label];
    
    return view;
}

- (void)addAnimation{
    POPBasicAnimation* animation = [POPBasicAnimation animationWithPropertyNamed:kPOPTableViewContentOffset];
    animation.duration = 1;
    CGPoint point = CGPointMake(0, CELL_HEIGHT);
    animation.toValue = [NSValue valueWithCGPoint:point];
    [animation setCompletionBlock:^(POPAnimation* animation, BOOL finish){
        self.tableView.contentOffset = CGPointZero;
        [self.tableView reloadData];
    }];
    [self.tableView pop_addAnimation:animation forKey:@"Y_SCROLL_ANIMATION"];
}

- (void)dealloc{
    if([timer isValid]){
        [timer invalidate];
    }
}

@end
