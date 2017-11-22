//
//  SnapViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "SnapViewController.h"

@interface SnapViewController ()

@end

@implementation SnapViewController

- (void)setupRightNavigationItem
{
    [super setupRightNavigationItem];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 创建一个view
    UIView *view = [self getLeadingActorView:CGRectMake(20, 66, 20, 20) backgroundColor:[self randomColor]];
    [self.view addSubview:view];
    
    // 创建震动行为，snapPoint是它的作用点
    self.snap = [[UISnapBehavior alloc] initWithItem:self.pointViews.firstObject snapToPoint:view.center];
    [self.animator addBehavior:self.snap];
    
    // 设置震动量，范围从0到1，默认为0.5
    self.snap.damping = 1;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 更改作用点
    [self changeSnapPoint:[touches.anyObject locationInView:self.view]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 更改作用点
    [self changeSnapPoint:[touches.anyObject locationInView:self.view]];
}

- (void)changeSnapPoint:(CGPoint)snapPoint
{
    self.snap.snapPoint = snapPoint;
}

@end
