//
//  YGNewViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGNewViewController.h"

@interface YGNewViewController ()

@end

@implementation YGNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick
{
    YGLogFunc;
}


@end
