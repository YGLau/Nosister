//
//  YGFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGFriendTrendsViewController.h"

@interface YGFriendTrendsViewController ()

@end

@implementation YGFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    friendButton.size = friendButton.currentBackgroundImage.size;
    [friendButton addTarget:self action:@selector(friendClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendButton];
}

- (void)friendClick
{
    YGLogFunc;
}

@end
