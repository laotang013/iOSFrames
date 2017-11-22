//
//  BaseViewController.h
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface BaseViewController : UIViewController

/**
 初始化方法

 @param title 导航栏标题
 */
- (instancetype)initWithTitle:(NSString *)title;

/**
 设置导航栏右边按钮
 */
- (void)setupRightNavigationItem;

/**
 随机颜色

 @return 随机颜色
 */
- (UIColor *)randomColor;

/**
 获取一个view

 @param frame frame
 @param backgroundColor 背景颜色
 @return view
 */
- (UIView *)getLeadingActorView:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;

/**
 重置
 */
- (void)reset;

/**
 存放所有的View
 */
@property (nonatomic, strong) NSMutableArray <UIView *> *pointViews;

/**
 运动管理对象
 */
@property (nonatomic, strong) CMMotionManager *motionManager;

/**
 物理仿真器(相当于一个存放运动行为的容器)
 */
@property (nonatomic, strong) UIDynamicAnimator *animator;

/**
 重力行为
 */
@property (nonatomic, strong) UIGravityBehavior *gravity;

/**
 碰撞行为
 */
@property (nonatomic, strong) UICollisionBehavior *collision;

/**
 吸附行为
 */
@property (nonatomic, strong) UIAttachmentBehavior *attach;

/**
 迅猛移动弹跳摆动行为
 */
@property (nonatomic, strong) UISnapBehavior *snap;

/**
 推动行为
 */
@property (nonatomic, strong) UIPushBehavior *push;

/**
 物体属性，如密度、弹性系数、摩擦系数、阻力、转动阻力等
 */
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItem;

/**
 屏幕上的描述
 */
@property (nonatomic, copy) NSString *describe;

@end
