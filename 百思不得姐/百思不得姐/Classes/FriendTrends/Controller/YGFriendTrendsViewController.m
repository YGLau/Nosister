//
//  YGFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGFriendTrendsViewController.h"
#import "YGRecommendViewController.h"
#import "YGLoginRegisterViewController.h"

@interface YGFriendTrendsViewController ()

@end

@implementation YGFriendTrendsViewController
/**
 *  登录注册
 */
- (IBAction)LoginRegister:(UIButton *)button {
    YGLoginRegisterViewController *loginVc = [[YGLoginRegisterViewController alloc] init];
    [self.navigationController presentViewController:loginVc animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
    self.view.backgroundColor = YGGlobalBg;
}

- (void)friendClick
{
    YGRecommendViewController *recoVc = [[YGRecommendViewController alloc] init];
    [self.navigationController pushViewController:recoVc animated:YES];
}

@end
