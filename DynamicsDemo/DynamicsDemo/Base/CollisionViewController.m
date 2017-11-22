//
//  CollisionViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "CollisionViewController.h"

@interface CollisionViewController ()

@end

@implementation CollisionViewController

- (void)setUpViews
{
    NSArray *frames = @[
                    [NSValue valueWithCGRect:CGRectMake(self.view.frame.size.width / 2 - 50, 64, 100, 20)],
                    [NSValue valueWithCGRect:CGRectMake(self.view.frame.size.width / 2 - 50, 150, 30, 30)],
                    [NSValue valueWithCGRect:CGRectMake(self.view.frame.size.width / 2 + 20, 230, 30, 30)],
                    [NSValue valueWithCGRect:CGRectMake(self.view.frame.size.width / 2 - 50, 310, 30, 30)]
                    ];
    
    for (NSInteger i = 0; i < 4; i++) {
        
        // 创建View
        UIView *view = [self getLeadingActorView:[frames[i] CGRectValue] backgroundColor:[self randomColor]];
        [self.view addSubview:view];
        
        // 添加碰撞效果
        [self.collision addItem:view];
    }
}

- (void)setupRightNavigationItem
{
    [self setUpViews];
    
    // 重置按钮
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    
    // 开始碰撞
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"开始碰撞" style:UIBarButtonItemStylePlain target:self action:@selector(beginCollision)];
    self.navigationItem.rightBarButtonItems = @[item1, item2];
}

- (void)reset
{
    [super reset];
    [self setUpViews];
}

- (void)beginCollision
{
    // 添加重力行为
    [self.gravity addItem:self.pointViews.firstObject];
}

@end
