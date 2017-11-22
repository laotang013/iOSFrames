//
//  GravitySpringViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "GravitySpringViewController.h"

@interface GravitySpringViewController () <UICollisionBehaviorDelegate>
@property (nonatomic, assign) BOOL isBig;
@property (nonatomic, strong) NSMutableArray *animators;

@end

@implementation GravitySpringViewController

- (NSMutableArray *)animators
{
    if (!_animators) {
        _animators = [NSMutableArray array];
    }
    return _animators;
}

- (void)addPoint:(CGPoint)point
{
    static NSInteger wh = 1;
    if (wh == 0) {
        _isBig = YES;
        wh = 1;
    }
    if (wh == 50) {
        _isBig = NO;
        wh = 49;
    }
    UIView *square = [self getLeadingActorView:(CGRect){point, wh % 50, wh % 50} backgroundColor:[self randomColor]];
    if (_isBig) {
        wh++;
    } else {
        wh--;
    }
    [self performSelector:@selector(removeView:) withObject:square afterDelay:5];
    square.layer.cornerRadius = wh / 2.0;
    [self.view addSubview:square];
    
    // 动态媒介
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [self.animators addObject:animator];
    // 重力
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
    [animator addBehavior:gravity];
    
    // 碰撞
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    collision.collisionDelegate = self;
    [collision addBoundaryWithIdentifier:@"barrier" forPath:[UIBezierPath bezierPathWithRect:self.view.bounds]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [animator addBehavior:collision];
    
    // 动力学属性
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    itemBehavior.elasticity = 1;
    [animator addBehavior:itemBehavior];
}

- (void)reset
{
    [super reset];
    [self.animators removeAllObjects];
}

- (void)removeView:(UIView *)view
{
    if (!view) {
        return;
    }
    [UIView animateWithDuration:.5 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        if ([self.pointViews containsObject:view]) {
            [self.pointViews removeObject:view];
            [view removeFromSuperview];
        }
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self addPoint:[touches.anyObject locationInView:self.view]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self addPoint:[touches.anyObject locationInView:self.view]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self addPoint:[touches.anyObject locationInView:self.view]];
}

@end
