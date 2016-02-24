//
//  SlideMenu.m
//  JQQIosDemo
//
//  Created by 季勤强 on 16/2/24.
//  Copyright © 2016年 季勤强. All rights reserved.
//

#import "SlideMenu.h"
#import "MenuButton.h"

static const CGFloat HELPER_WIDTH = 40.0;
static const CGFloat BLANK_MENU_WIDTH = 50.0;
static const CGFloat BUTTON_SPACE = 30.0;

@interface SlideMenu ()

@property (nonatomic, strong)CADisplayLink* displayLink;

@property (nonatomic)NSUInteger animationCount;

@end

@implementation SlideMenu{
    UIView* helpView;
    UIView* helpCenterView;
    UIWindow* keyWindow;
    UIVisualEffectView* blurView;
    BOOL trigger;
    CGFloat diff;
    CGFloat menuButtonHeight;
    UIColor* menuColor;
}

- (instancetype)initWithTitles:(NSArray*)titles{
    return [self initWithTitles:titles buttonHeight:40.0f menuColor:[UIColor colorWithRed:0 green:0.722 blue:1 alpha:1]];
}

- (instancetype)initWithTitles:(NSArray*)titles buttonHeight:(CGFloat)height menuColor:(UIColor*)color{
    self = [super init];
    if(self){
        keyWindow = [[UIApplication sharedApplication] keyWindow];
        
        blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        blurView.frame = keyWindow.frame;
        blurView.alpha = 0;
        
        helpView = [[UIView alloc] initWithFrame:CGRectMake(-HELPER_WIDTH, 0, HELPER_WIDTH, HELPER_WIDTH)];
        helpView.backgroundColor = [UIColor redColor];
        helpView.hidden = YES;
        [keyWindow addSubview:helpView];
        
        helpCenterView = [[UIView alloc] initWithFrame:CGRectMake(-HELPER_WIDTH, CGRectGetHeight(keyWindow.frame), HELPER_WIDTH, HELPER_WIDTH)];
        helpCenterView.backgroundColor = [UIColor yellowColor];
        helpCenterView.hidden = YES;
        [keyWindow addSubview:helpCenterView];
        
        self.frame = CGRectMake(-keyWindow.frame.size.width/2 - BLANK_MENU_WIDTH, 0, keyWindow.frame.size.width/2 + BLANK_MENU_WIDTH, keyWindow.frame.size.height);
        self.backgroundColor = [UIColor clearColor];
        [keyWindow insertSubview:self belowSubview:helpView];
        
        menuButtonHeight = height;
        menuColor = color;
        
        [self addButtons:titles];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(keyWindow.frame.size.width/2, 0)];
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width - BLANK_MENU_WIDTH, keyWindow.frame.size.height) controlPoint:CGPointMake(keyWindow.frame.size.width/2 + diff, keyWindow.frame.size.height/2)];
    [path addLineToPoint:CGPointMake(0, keyWindow.frame.size.height)];
    [path closePath];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    [menuColor set];
    CGContextFillPath(context);
}

#pragma Public Method

- (void)trigger{
    if(!trigger){
        [keyWindow insertSubview:blurView belowSubview:self];
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.bounds;
        }];
        
        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.9 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
            helpView.center = CGPointMake(keyWindow.frame.size.width/2, 0);
        }completion:^(BOOL finished){
            [self finishAnimation];
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            blurView.alpha = 1.0;
        }];
        
        [self beforeAnimation];
        [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:2.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            helpCenterView.center = keyWindow.center;
        }completion:^(BOOL finished){
            if(finished){
                UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(unTrigger)];
                [blurView addGestureRecognizer:tap];
                [self finishAnimation];
            }
        }];
        [self buttonAnimator];
        trigger = YES;
    }else{
        [self unTrigger];
    }
}

#pragma Action

- (void)displayLinkAction:(CADisplayLink*)displayLink{
    CALayer* layer = (CALayer*)helpView.layer.presentationLayer;
    CALayer* centerLayer = (CALayer*)helpCenterView.layer.presentationLayer;
    
    /**
    valueForKey: and valueForKeyPath: provide information about object instances and interact with the dynamic nature of the Objective-C runtime. objectForKey: is a dictionary specific method that does dictionary tasks.
     **/
    
    CGRect rect = [[layer valueForKeyPath:@"frame"] CGRectValue];
    CGRect centerRect = [[centerLayer valueForKeyPath:@"frame"] CGRectValue];
    
    diff = rect.origin.x - centerRect.origin.x;
    
    [self setNeedsDisplay];
}

#pragma Private Method

- (void)addButtons:(NSArray*)titles{
    float y = 50;
    for (int i = 0; i < [titles count]; i++) {
        MenuButton* menuButton = [[MenuButton alloc] initWithTitle:titles[i]];
        menuButton.frame = CGRectMake(20, y, keyWindow.frame.size.width/2 - 40, menuButtonHeight);
        menuButton.buttonColor = menuColor;
        [self addSubview:menuButton];
        
        y += menuButtonHeight + 30;
        
        __weak typeof(self) weakSelf = self;
        menuButton.clickedBlock = ^{
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf unTrigger];
            if(strongSelf.buttonClickedBlock)
                strongSelf.buttonClickedBlock(i);
        };
    }
}

- (void)buttonAnimator{
    for (int i = 0; i < self.subviews.count; i++) {
        UIView* menuButton = self.subviews[i];
        menuButton.transform = CGAffineTransformMakeTranslation(-90, 0);
        [UIView animateWithDuration:0.7 delay:i * 0.3/self.subviews.count usingSpringWithDamping:0.6f initialSpringVelocity:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
            menuButton.transform = CGAffineTransformIdentity;
        }completion:nil];
    }
}

- (void)beforeAnimation{
    if(self.displayLink == nil){
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.animationCount++;
}

- (void)finishAnimation{
    if(self.animationCount == 0){
        [self.displayLink invalidate];
        self.displayLink = nil;
    }
    self.animationCount--;
}

- (void)unTrigger{
    [UIView animateWithDuration:0.3 animations:^{
       self.frame = CGRectMake(-keyWindow.frame.size.width/2 - BLANK_MENU_WIDTH, 0, keyWindow.frame.size.width/2 + BLANK_MENU_WIDTH, keyWindow.frame.size.height);
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:0.9f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        helpView.center = CGPointMake(-helpView.frame.size.height/2, helpView.frame.size.height/2);
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        blurView.alpha = 0.0f;
    }];
    
    [self beforeAnimation];
    [UIView animateWithDuration:0.7 delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:2.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction animations:^{
        helpCenterView.center = CGPointMake(-helpCenterView.frame.size.height/2, CGRectGetHeight(keyWindow.frame)/2);
    } completion:^(BOOL finished) {
        [self finishAnimation];
    }];    
    trigger = NO;
}

@end
