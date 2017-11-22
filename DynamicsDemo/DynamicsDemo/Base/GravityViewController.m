//
//  GravityViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "GravityViewController.h"

@interface GravityViewController ()

@end

@implementation GravityViewController

- (void)addPoint:(CGPoint)point
{
    UIView *view = [self getLeadingActorView:(CGRect){point, 50, 50} backgroundColor:[UIColor redColor]];
    [self.view addSubview:view];
    [self.gravity addItem:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self addPoint:[touches.anyObject locationInView:self.view]];
}

@end
