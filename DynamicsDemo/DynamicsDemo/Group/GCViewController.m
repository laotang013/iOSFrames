//
//  GCViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "GCViewController.h"

@interface GCViewController ()

@end

@implementation GCViewController

- (void)addPoint:(CGPoint)point
{
    // 创建一个view
    UIView *view = [self getLeadingActorView:(CGRect){point, 20 + (arc4random() % 61), 40 + (arc4random() % 41)} backgroundColor:[self randomColor]];
    [self.view addSubview:view];
    
    // 为view添加重力效果
    [self.gravity addItem:view];
    // 为view添加碰撞效果
    [self.collision addItem:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self addPoint:[touches.anyObject locationInView:self.view]];
}

@end
