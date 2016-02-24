//
//  MenuButton.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "MenuButton.h"

@interface MenuButton ()

@property (nonatomic, copy)NSString* buttonTitle;

@end

@implementation MenuButton

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if(self){
        self.buttonTitle = title;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    [self.buttonColor set];
    CGContextFillPath(context);
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 1, 1) cornerRadius:rect.size.height/2];
    [self.buttonColor setFill];
    [path fill];
    [[UIColor whiteColor] setStroke];
    path.lineWidth = 1;
    [path stroke];
    
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary* attrDic = @{NSParagraphStyleAttributeName: style, NSFontAttributeName: [UIFont systemFontOfSize:24], NSForegroundColorAttributeName: [UIColor whiteColor]};
    CGSize size = [self.buttonTitle sizeWithAttributes:attrDic];
    
    CGRect r = CGRectMake(rect.origin.x, rect.origin.y + (rect.size.height - size.height)/2, rect.size.width, rect.size.height);
    
    [self.buttonTitle drawInRect:r withAttributes:attrDic];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    NSUInteger tapCount = [touch tapCount];
    switch (tapCount) {
        case 1:
            if(self.clickedBlock)
                self.clickedBlock();
            break;
            
        default:
            break;
    }
}

@end
