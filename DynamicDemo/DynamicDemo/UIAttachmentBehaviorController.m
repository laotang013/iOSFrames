



//
//  UIAttachmentBehaviorController.m
//  DynamicDemo
//
//  Created by Start on 2017/11/22.
//  Copyright © 2017年 het. All rights reserved.
//

#import "UIAttachmentBehaviorController.h"

@interface UIAttachmentBehaviorController ()
/**绿色方框*/
@property(nonatomic,strong)UIView *squareView;
/**brown*/
@property(nonatomic,strong)UIView *brownView;
/**redView*/
@property(nonatomic,strong)UIView *redView;
/**animator*/
@property(nonatomic,strong)UIDynamicAnimator *animator;
/**吸附属性*/
@property(nonatomic,strong)UIAttachmentBehavior *attachBehavior;
@end

@implementation UIAttachmentBehaviorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupSubViews
{
    self.squareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    self.brownView = [[UIView alloc]initWithFrame:CGRectMake(60, 0, 20, 20)];
    self.brownView.backgroundColor = [UIColor brownColor];
    [self.squareView addSubview:self.brownView];
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(120, 120, 20, 20)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.squareView];
    [self.squareView addSubview:self.brownView];
    [self.view addSubview:self.redView];
    //设置平移
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesSelector:)];
    [self.view addGestureRecognizer:panGes];
    //设置物理属性
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //碰撞属性
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[self.squareView]];
    //物理边界
    collision.translatesReferenceBoundsIntoBoundary = YES;
    //吸附
    UIOffset offset = UIOffsetMake(self.brownView.center.x, self.brownView.center.y);
    //self.attachBehavior = [[UIAttachmentBehavior alloc]initWithItem:self.squareView offsetFromCenter:offset attachedToAnchor:self.redView.center];
    [self.animator addBehavior:collision];
    self.attachBehavior  = [[UIAttachmentBehavior alloc]initWithItem:self.squareView attachedToAnchor:self.redView.center];
    [self.animator addBehavior:self.attachBehavior];
}

-(void)panGesSelector:(UIPanGestureRecognizer *)panGes
{
    CGPoint tapPoint = [panGes locationInView:self.view];
    [self.attachBehavior setAnchorPoint:tapPoint];
    self.redView.center = tapPoint;
}
@end
