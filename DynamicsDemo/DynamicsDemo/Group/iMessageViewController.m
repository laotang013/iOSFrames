//
//  iMessageViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/3.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "iMessageViewController.h"
#import "WZBCollectionViewLayout.h"

@interface iMessageViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) WZBCollectionViewLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *cellId = @"cellId";

@implementation iMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // 设置collectionView
    WZBCollectionViewLayout *layout = [[WZBCollectionViewLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, 50);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 70;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.contentView.backgroundColor = [self randomColor];
    return cell;
}

@end
