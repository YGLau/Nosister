//
//  YGRecommendViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/16.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface YGRecommendViewController ()

@end

@implementation YGRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = YGGlobalBg;
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://21q3214" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        YGLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
    }];
}



@end
