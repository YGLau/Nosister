//
//  YGLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/20.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGLoginRegisterViewController.h"

@interface YGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bg;
/**
 *  左边的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end

@implementation YGLoginRegisterViewController
/**
 *  退出控制器
 */
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  登录或注册
 */
- (IBAction)LoginRegister:(id)button {
    if (self.leftConstraint.constant == 0) { // 显示注册界面
        self.leftConstraint.constant = - self.view.width;
        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
        
    } else {  // 显示登录界面
        self.leftConstraint.constant = 0;
        [button setTitle:@"立即登录" forState:UIControlStateNormal];
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    // 退出键盘
    [self.view endEditing:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.bg atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  控制状态栏颜色
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent; // 显示白色
}

@end
