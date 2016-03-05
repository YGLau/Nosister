//
//  YGMeViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGMeViewController.h"
#import "YGMeCell.h"
#import "YGMeFooterView.h"

static NSString * const YGMeCellID = @"me";

@interface YGMeViewController ()

@end

@implementation YGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTableView];
}
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏左边的按钮
    UIBarButtonItem *setingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[setingItem, moonItem];
    
    self.tableView.backgroundColor = YGGlobalBg;
}
- (void)settingClick
{
    YGLogFunc;
}

- (void)moonClick
{
    YGLogFunc;
}
- (void)setupTableView
{
    // 注册cell
    [self.tableView registerClass:[YGMeCell class] forCellReuseIdentifier:YGMeCellID];
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 调整header和footer高度
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = YGTopicCellMargin;
    // 设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(YGTopicCellMargin - 35, 0, 547, 0);
    self.tableView.contentSize = CGSizeMake(0, 1000);
    YGLog(@"%f", self.tableView.height);

    
    // 设置footerView
    self.tableView.tableFooterView = [[YGMeFooterView alloc] init];
}


#pragma mark - UITableViewDelegate方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:YGMeCellID];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
        
    } else {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

@end
