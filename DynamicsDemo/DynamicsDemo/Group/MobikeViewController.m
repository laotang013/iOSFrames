//
//  MobikeViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "MobikeViewController.h"

@interface MobikeViewController ()

@end

@implementation MobikeViewController

- (void)setupRightNavigationItem
{
    [super setupRightNavigationItem];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 创建view
    for (NSInteger i = 0; i < 8; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MobikeTest"]];
        imageView.frame = CGRectMake(100, 0, 50, 50);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 25;
        [self.view addSubview:imageView];
        
        // 添加重力效果
        [self.gravity addItem:imageView];
        // 碰撞效果
        [self.collision addItem:imageView];
        self.dynamicItem.elasticity = .7;
        // 添加动力学属性
        [self.dynamicItem addItem:imageView];
    }
    
    // 开始监听
    [self.motionManager startDeviceMotionUpdatesToQueue:NSOperationQueue.mainQueue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        // 设置重力方向
        self.gravity.gravityDirection = CGVectorMake(motion.gravity.x * 3, -motion.gravity.y * 3);
    }];
}

@end
