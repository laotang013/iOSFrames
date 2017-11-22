//
//  ViewController.m
//  DynamicsDemo
//
//  Created by 王振标 on 2017/8/2.
//  Copyright © 2017年 王振标. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *describes;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    // 创建全局数组
    self.viewControllers = @[
                             @"GravityViewController",
                             @"CollisionViewController",
                             @"AttachViewController",
                             @"PushViewController",
                             @"SnapViewController",
                             @"GCViewController",
                             @"GravitySpringViewController",
                             @"MobikeViewController",
                             @"iMessageViewController",
                             @"BDWMViewController"
                             ];
    
    self.titles = @[
                    @"重力",
                    @"碰撞",
                    @"吸附",
                    @"推力",
                    @"摆动",
                    @"重力+碰撞",
                    @"重力弹跳",
                    @"防摩拜单车贴纸效果(需真机运行)",
                    @"防iMessage滚动效果",
                    @"百度外卖首页重力感应(需真机运行)"
                    ];
    
    self.describes = @[
                       @"点击屏幕开始",
                       @"点击“开始碰撞”按钮",
                       @"拖动红色view",
                       @"点击屏幕开始",
                       @"点击或拖动屏幕开始",
                       @"点击屏幕开始",
                       @"在屏幕上拖动",
                       @"倾斜手机试试",
                       @"上下滚动屏幕",
                       @"左右倾斜手机"
                       ];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class c = NSClassFromString(self.viewControllers[indexPath.row]);
    BaseViewController *vc = [[c alloc] initWithTitle:self.titles[indexPath.row]];
    vc.describe = self.describes[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
