//
//  BaseViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation BaseViewController

#pragma mark - lazy
- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        [self.view addSubview:_descLabel];
        _descLabel.textColor = [UIColor lightGrayColor];
    }
    return _descLabel;
}

- (NSMutableArray *)pointViews
{
    if (!_pointViews) {
        _pointViews = [NSMutableArray array];
    }
    return _pointViews;
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (UIGravityBehavior *)gravity
{
    if (!_gravity ) {
        _gravity = [[UIGravityBehavior alloc] init];
        [self.animator addBehavior:_gravity];
    }
    return _gravity;
}

- (UICollisionBehavior *)collision
{
    if (!_collision) {
        _collision = [[UICollisionBehavior alloc] init];
        [self.animator addBehavior:_collision];
        _collision.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collision;
}

/*
- (UIAttachmentBehavior *)attach
{
    if (!_attach) {
        _attach = [[UIAttachmentBehavior alloc] init];
        _attach.damping = 0;
        _attach.frequency = 0.5;
         吸附类型：连接到视图View，至少需要两个动力项
        _attach.attachedBehaviorType = UIAttachmentBehaviorTypeItems;
         UIAttachmentBehaviorTypeAnchor 连接到锚点（只有一个动力项）
    }
    return _attach;
}
*/

- (UIPushBehavior *)push
{
    if (!_push) {
        _push = [[UIPushBehavior alloc] init];
        // mode : 推力模式，UIPushBehaviorModeContinuous：持续型。UIPushBehaviorModeInstantaneous：一次性推力。
//        _push.mode = UIPushBehaviorModeContinuous;
        
        // 推力是否被激活，在激活状态下，物体才会受到推力效果
        _push.active = YES;
        
        // 推力的大小和方向, 是一个平面向量，表示推力的力和方向
//        _push.pushDirection = CGVectorMake(<#CGFloat dx#>, <#CGFloat dy#>);
        
        [self.animator addBehavior:_push];
    }
    return _push;
}

//- (UISnapBehavior *)snap
//{
//    if (!_snap) {
//        _snap = [[UISnapBehavior alloc] initWithItem:nil snapToPoint:CGPointZero];
//        // 设置item要在哪个点上震动
//        _snap.snapPoint = CGPointZero;
//        // 减震系数,弹性的迅猛度，范围在0.0~1.0,默认值为0.5
//        _snap.damping = 0.5;
//    }
//    return _snap;
//}

- (UIDynamicItemBehavior *)dynamicItem
{
    if (!_dynamicItem) {
        _dynamicItem = [[UIDynamicItemBehavior alloc] init];
        [self.animator addBehavior:_dynamicItem];
        // 弹力, 通常0~1之间
        _dynamicItem.elasticity = 1;
        // 摩擦力，0表示完全光滑无摩擦
//        _dynamicItem.friction = 0;
        // 密度，一个 100x100 points（1 point 在 retina 屏幕上等于2像素，在普通屏幕上为1像素。）大小的物体，密度1.0，在上面施加 1.0 的力，会产生 100 point/平方秒 的加速度。
//        _dynamicItem.density = 1;
        // 线性阻力，物体在移动过程中受到的阻力大小
//        _dynamicItem.resistance = 1;
        // 旋转阻力，物体旋转过程中的阻力大小
//        _dynamicItem.angularResistance = 1;
        // 是否允许旋转
//        _dynamicItem.allowsRotation = YES;
    }
    return _dynamicItem;
}

- (CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        
        // 设备状态更新帧率
        _motionManager.deviceMotionUpdateInterval = 0.01;
    }
    return _motionManager;
}

#pragma mark - systemMethod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupRightNavigationItem];
}

#pragma mark - init
- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    return self;
}

#pragma mark - set
- (void)setDescribe:(NSString *)describe
{
    _describe = describe;
    self.descLabel.text = describe;
    [self.descLabel sizeToFit];
    self.descLabel.center = self.view.center;
}

#pragma mark - privateMethod
- (UIColor *)randomColor
{
    return [UIColor colorWithRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha:1];
}

- (UIView *)getLeadingActorView:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    UIView *leadingActor = [[UIView alloc] initWithFrame:frame];
    [self.pointViews addObject:leadingActor];
    leadingActor.backgroundColor = backgroundColor;
    leadingActor.layer.shadowColor = backgroundColor.CGColor;
    leadingActor.layer.shadowOffset = CGSizeMake(10, 10);
    leadingActor.layer.shadowOpacity = 0.2;
    leadingActor.layer.shadowRadius = 5;
    return leadingActor;
}

- (void)setupRightNavigationItem
{
    // 重置按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
}

- (void)reset
{
    [self.pointViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.pointViews removeAllObjects];
    [self.animator removeAllBehaviors];
    _gravity = nil;
    _collision = nil;
    _attach = nil;
    _snap = nil;
    _push = nil;
}
@end
