//
//  BDWMViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/4.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "BDWMViewController.h"
#import "BDWMCollectionViewCell.h"
#import "WZBCollectionViewLayout.h"

@interface BDWMViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BDWMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    WZBCollectionViewLayout *layout = [[WZBCollectionViewLayout alloc] init];
    CGFloat wh = self.view.frame.size.width / 5;
    layout.itemSize = CGSizeMake(wh, wh - 15);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, wh * 2 - 15) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.canCancelContentTouches = YES;
    collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"BDWMCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionViewCellId"];
    [self start];
}

- (void)start
{
    // 加速计更新频率，我这里设置每隔0.06s更新一次，也就是说，每隔0.06s会调用一次下边这个监听的block
    self.motionManager.accelerometerUpdateInterval = 0.06;
    // 开始监听
    [self.motionManager startAccelerometerUpdatesToQueue:NSOperationQueue.mainQueue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        // 获取加速计在x方向上的加速度
        CGFloat x = accelerometerData.acceleration.x;
        
        // collectionView的偏移量
        CGFloat offSetX = self.collectionView.contentOffset.x;
        CGFloat offSetY = self.collectionView.contentOffset.y;
        
        // 动态修改偏移量
        offSetX -= 15 * x;
        CGFloat maxOffset = self.collectionView.contentSize.width + 15 - self.view.frame.size.width;
        
        // 判断最大和最小的偏移量
        if (offSetX > maxOffset) {
            offSetX = maxOffset;
        } else if (offSetX < -15) {
            offSetX = -15;
        }
        
        // 动画修改collectionView的偏移量
        [UIView animateWithDuration:0.06 animations:^{
            [self.collectionView setContentOffset:CGPointMake(offSetX, offSetY) animated:NO];
        }];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BDWMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCellId" forIndexPath:indexPath];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.motionManager stopAccelerometerUpdates];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self afterDelayBegin:3];
}

- (void)afterDelayBegin:(NSTimeInterval)interval {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(start) object:nil];
    [self performSelector:@selector(start) withObject:nil afterDelay:3];
}

@end
