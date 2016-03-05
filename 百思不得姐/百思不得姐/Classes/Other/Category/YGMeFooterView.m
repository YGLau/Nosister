//
//  YGMeFooterView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/5.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGMeFooterView.h"
#import <AFNetworking.h>
#import "YGMeButton.h"
#import "YGSquare.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "YGWebViewController.h"

@implementation YGMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    if (self = [super initWithFrame:frame]) {
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            NSArray *squares = [YGSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    return self;
}

- (void)createSquares:(NSArray *)squares
{
    NSInteger cols = 4;
    CGFloat btnW = YGmainScreenW / cols;
    CGFloat btnH = btnW;
    for (NSInteger i = 0; i < squares.count; i++) {
        YGMeButton *button = [YGMeButton buttonWithType:UIButtonTypeCustom];
        button.Square = squares[i];
        
        CGFloat col = i % cols;
        CGFloat row = i / cols;
        
        button.x = col * btnW;
        button.y = row * btnH;
        button.width = btnW;
        button.height = btnH;
        [self addSubview:button];
        
        // 监听按钮点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    NSInteger rows = (squares.count +cols - 1) / cols;
    self.height = rows * btnH;
    // 重绘
    [self setNeedsDisplay];
    
}
- (void)buttonClick:(YGMeButton *)button
{
    if (![button.Square.url hasPrefix:@"http"]) return;
    YGWebViewController *web = [[YGWebViewController alloc] init];
    web.url = button.Square.url;
    web.title = button.Square.name;
    UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabbarVc.selectedViewController;
    [nav pushViewController:web animated:YES];
}
//- (void)drawRect:(CGRect)rect 
//{
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}

@end
