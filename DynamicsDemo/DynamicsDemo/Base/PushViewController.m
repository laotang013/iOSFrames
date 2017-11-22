//
//  PushViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    UIView *view = [self getLeadingActorView:CGRectMake(0, 64, 80, 80) backgroundColor:[self randomColor]];
    [self.view addSubview:view];
    view.layer.cornerRadius = 40;
    [self.push addItem:view];
    [self.collision addItem:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIView *square = self.pointViews.firstObject;
    // 创建推力行为
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[square] mode:UIPushBehaviorModeInstantaneous];
    CGPoint location = [touches.anyObject locationInView:self.view];
    CGPoint itemCenter = square.center;
    
    // 设置推力方向
    push.pushDirection = CGVectorMake((location.x - itemCenter.x) / 300, (location.y - itemCenter.y) / 300);
    [self.animator addBehavior:push];
}

@end
