//
//  WZBCollectionViewLayout.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "WZBCollectionViewLayout.h"

@interface WZBCollectionViewLayout ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation WZBCollectionViewLayout

// 重写prepareLayout方法
- (void)prepareLayout
{
    [super prepareLayout];
    
    if (!_animator) {
        // 创建一个仿真者[UIDynamicAnimator] 用来仿真物理行为
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        for (UICollectionViewLayoutAttributes *item in items) {
            // 创建一个吸附行为
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
            spring.length = 0;
            spring.damping = .8;
            spring.frequency = .5;
            [_animator addBehavior:spring];
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [_animator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_animator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDeltaY = newBounds.origin.y - scrollView.bounds.origin.y;
    CGFloat scrollDeltaX = newBounds.origin.x - scrollView.bounds.origin.x;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    for (UIAttachmentBehavior *spring in _animator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 2000;
        UICollectionViewLayoutAttributes *item = (id)[spring.items firstObject];
        CGPoint center = item.center;
        center.y += (scrollDeltaY > 0) ? MIN(scrollDeltaY, scrollDeltaY * scrollResistance)
        : MAX(scrollDeltaY, scrollDeltaY * scrollResistance);
        
        CGFloat distanceFromTouchX = fabs(touchLocation.x - anchorPoint.x);
        center.x += (scrollDeltaX > 0) ? MIN(scrollDeltaX, scrollDeltaX * distanceFromTouchX / 2000)
        : MAX(scrollDeltaX, scrollDeltaX * distanceFromTouchX / 2000);
        
        item.center = center;
        [_animator updateItemUsingCurrentState:item];
    }
    return NO;
}
@end
