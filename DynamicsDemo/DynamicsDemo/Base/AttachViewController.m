//
//  AttachViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "AttachViewController.h"

@interface AttachViewController ()

@property (nonatomic, strong) UIView *squareView;
@property (nonatomic, strong) UIView *anchorView;

@end

@implementation AttachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //创建拖动手势
    [self createGestureRecognizer];
    [self createSmallSquareView];
    //创建锚点，基准视图
    [self createAnchorView];
    //创建关联动画
    [self createAnimatorAndBehaviors];
}

- (void) createSmallSquareView{
    self.squareView = [[UIView alloc] initWithFrame:  CGRectMake(100, 100, 20, 20)];
    self.squareView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.squareView];
}
- (void) createAnchorView{
    self.anchorView = [[UIView alloc] initWithFrame: CGRectMake(100, 150, 20, 20)];
    self.anchorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.anchorView];
}
- (void)handlePan:(UIPanGestureRecognizer *)paramPan {
    //拖动的点作为锚点
    CGPoint tapPoint = [paramPan locationInView:self.view];
    [self.attach setAnchorPoint:tapPoint];
    self.anchorView.center = tapPoint;
}
- (void)createAnimatorAndBehaviors {
    self.attach = [[UIAttachmentBehavior alloc] initWithItem:self.squareView offsetFromCenter:UIOffsetZero attachedToAnchor:self.anchorView.center];
    // anchorPoint : 类型的依赖行为的锚点，锚点与行为相关的动力动画的坐标系统有关
    // items : 与吸附行为相连的动态项目，当吸附行为类型是UIAttachmentBehaviorTypeItems时有2个元素，当吸附行为类型是UIAttachmentBehaviorTypeAnchor时只有一个元素。

    // 吸附行为中的两个吸附点之间的距离，通常用这个属性来调整吸附的长度，可以创建吸附行为之后调用。系统基于你创建吸附行为的方法来自动初始化这个长度
    self.attach.length = 60;
    
    // 吸附行为震荡的频率
    self.attach.frequency = .3;
    // 描述吸附行为减弱的阻力大小
    self.attach.damping = .3;
    [self.animator addBehavior:self.attach];
}

- (void)createGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}
@end
