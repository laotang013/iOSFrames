



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
/**UIPushBehavior*/
@property(nonatomic,strong)UIPushBehavior *pushBehavior;
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
    [self test2];
 
}
//吸附
-(void)test1
{
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
    [self.attachBehavior setFrequency:1.0f];//设置对象的振幅和摆动大小
    [self.attachBehavior setDamping:0.1f];//用于校平动画峰值
    [self.attachBehavior setLength:100.f];//根据其初始位置进行调整
    [self.animator addBehavior:self.attachBehavior];
}
-(void)panGesSelector:(UIPanGestureRecognizer *)panGes
{
    CGPoint tapPoint = [panGes locationInView:self.view];
    [self.attachBehavior setAnchorPoint:tapPoint];
    self.redView.center = tapPoint;
    //瞬间位移
//    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.redView snapToPoint:tapPoint];
//    snapBehavior.damping = 0.75f;
//    [self.animator addBehavior:snapBehavior];
    //推力计算
    CGPoint origin = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    CGFloat distance = sqrtf(powf(tapPoint.x - origin.x,2.0)+powf(tapPoint.y-origin.y, 2.0));
    CGFloat angle = atan2(tapPoint.y-origin.y, tapPoint.x-origin.x);
    distance = MIN(distance, 100.f);
    [self.pushBehavior setMagnitude:angle];
    [self.pushBehavior setActive:YES];
}


//推力
-(void)test2
{
    //设置物理属性
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UICollisionBehavior *collectionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.squareView]];
    collectionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc]initWithItems:@[self.squareView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior = pushBehavior;
    pushBehavior.angle = 0.0;
    pushBehavior.magnitude = 0.0f;
    [self.animator addBehavior:pushBehavior];
    //设置平移
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesSelector:)];
    [self.view addGestureRecognizer:panGes];
    
    //元素属性
    
}

-(void)test3
{
    /*
     * UIDynamic 可以为继承UIView的控件添加物理行为。
     * Dynamic Animator动画者 为动力学元素提供物理学相关的能力及动画。同时为这些元素提供相关的上下文。
     * 是动力学与底层iOS物理引擎之间的中介。将Behavior对象添加到Animator即可实现动力仿真。
     * Dynamic Animator Item:动力学元素，是任何遵守了UIDynamic协议的对象，从iOS7开始，UIView和UICollectionViewLayoutAttributes默认实现协议，如果自定义对象实现了该协议，即可通过Dynamic Animator实现物理仿真。
     * 具体实现步骤：
     1、创建一个仿真者[UIDynamicAnimator] 用来仿真所有的物理行为
     2、创建具体的物理仿真行为[如重力UIGravityBehavior]
     3、将物理仿真行为添加给仿真者实现仿真效果。
     

     */
}

@end
