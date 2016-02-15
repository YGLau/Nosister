//
//  YGEssenceViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGEssenceViewController.h"
#import "YGTestViewController.h"

@interface YGEssenceViewController ()

@end

@implementation YGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = YGGlobalBg;
}

- (void)tagClick
{
    YGLogFunc;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YGTestViewController *vc = [[YGTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
