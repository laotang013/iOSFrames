//
//  GravityViewController.m
//  DynamicDemo
//
//  Created by Start on 2017/11/17.
//  Copyright © 2017年 het. All rights reserved.
//

#import "GravityViewController.h"

@interface GravityViewController ()<UICollisionBehaviorDelegate,UIGestureRecognizerDelegate>
/**animator*/
@property(nonatomic,strong)UIDynamicAnimator *animator;
/**平移手势*/
@property(nonatomic,strong)UIPanGestureRecognizer *panGes;
/**UIImageView*/
@property(nonatomic,strong)UIImageView *iconImageView;
/**UIImageVIew2*/
@property(nonatomic,strong)UIImageView *iconImageViewTwo;
@end

@implementation GravityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.panGes = [[UIPanGestureRecognizer alloc]init];
    [self.iconImageView addGestureRecognizer:self.panGes];
    self.panGes.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.iconImageViewTwo];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    /*
     UIGravityBehavior：重力行为
     UICollisionBehavior：碰撞行为
     UISnapBehavior：捕捉行为
     UIPushBehavior：推动行为
     UIAttachmentBehavior：附着行为
     UIDynamicItemBehavior：动力元素行为
     所有物理仿真行为都继承自UIDynamicBehavior
     所有的UIDynamicBehavior都可以独立进行
     组合使用多种行为时，可以实现一些比较复杂的效果
     */
}
#pragma mark - method
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self test1];
    [self test2];
    [self test3];
}
//重力效果
-(void)test1
{
    //步骤: 1.创建一个物理仿真器。设置仿真范围 2.创建相应的物理仿真行为。添加物理仿真元素 3. 将物理仿真行为添加到仿真器中开始仿真。
    //在我们构建UIDynamicAnimator对象时一定要被其它对象有效持有，不然在arc模式下将很快被自动释放。
    //创建一个物理仿真器
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    // 创建重力行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[self.iconImageView,self.iconImageViewTwo]];
    //magnitude越大，速度增长越快
    gravityBehavior.magnitude = 10;
    [self.animator addBehavior:gravityBehavior];
}
//碰撞效果
-(void)test2
{
    UICollisionBehavior *collsionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self.iconImageView,self.iconImageViewTwo]];
    //如果要想在程序中的对象和边界发生互动关系。需要先对边界定义 translatesReferenceBoundsIntoBoundary设置为YES. 本例用于self.view对象。边界也可以用于其他路径
    collsionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    //代理回调 4个回调方法 两个用于碰撞开始两个用于碰撞结束每一个回调集都有一个方法
    collsionBehavior.collisionDelegate = self;
    /*
     UICollisionBehaviorModeItems   参数会使元素相互碰撞
     UICollisionBehaviorModeBoundaries   参数会使元素虽然不会发生碰撞，但是会和边界发生碰撞
     UICollisionBehaviorModeEverything   参数会使元素在相互之间和同边界都发生碰撞
     */
    [collsionBehavior setCollisionMode:UICollisionBehaviorModeBoundaries];
    [self.animator addBehavior:collsionBehavior];
}
//吸附效果
-(void)test3
{
    CGPoint centerPoint = CGPointMake(self.iconImageView.center.x, self.iconImageView.center.y);
    UIAttachmentBehavior *attchment = [[UIAttachmentBehavior alloc]initWithItem:self.iconImageViewTwo attachedToAnchor:centerPoint];
    [self.animator addBehavior:attchment];
    
}

#pragma mark -collisionDelegate
-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    NSLog(@"碰撞开始");
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    NSLog(@"碰撞结束");
}
#pragma mark - 平移手势

#pragma mark - getter&setter
-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = [UIImage imageNamed:@"Interget"];
        _iconImageView.frame = CGRectMake(100, 100, 50, 50);
    }
    return _iconImageView;
}
-(UIImageView *)iconImageViewTwo
{
    if (!_iconImageViewTwo) {
        _iconImageViewTwo = [[UIImageView alloc]init];
        _iconImageViewTwo.image = [UIImage imageNamed:@"integral_icon_sleepTask"];
        _iconImageViewTwo.frame = CGRectMake(200, 100, 50, 50);
    }
    return _iconImageViewTwo;
}
@end
