//
//  YGPostWordViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/6.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPostWordViewController.h"

@interface YGPostWordViewController ()

@end

@implementation YGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表文字";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
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
