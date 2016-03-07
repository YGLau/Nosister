//
//  YGPostWordViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/6.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPostWordViewController.h"
#import "YGPlaceholderView.h"

@interface YGPostWordViewController ()

@end

@implementation YGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.title = @"发表文字";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded]; // 强制刷新
}

- (void)setupTextView
{
    YGPlaceholderView *textView = [[YGPlaceholderView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片、好笑的段子或糗事发到这里，接受万千网友的膜拜吧！发布违法反国家内容的，我们将依法提交给有关部门处理";
    [self.view addSubview:textView];
}

#pragma mark - 导航控制器的取消和完成方法
/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    
}

@end
