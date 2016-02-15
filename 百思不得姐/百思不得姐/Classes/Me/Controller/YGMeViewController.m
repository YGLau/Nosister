//
//  YGMeViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGMeViewController.h"

@interface YGMeViewController ()

@end

@implementation YGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏左边的按钮
    UIBarButtonItem *setingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[setingItem, moonItem];
    
    self.view.backgroundColor = YGGlobalBg;
}

- (void)settingClick
{
    YGLogFunc;
}

- (void)moonClick
{
    YGLogFunc;
}

@end
