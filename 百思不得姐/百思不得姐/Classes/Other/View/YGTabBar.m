//
//  YGTabBar.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTabBar.h"
#import "YGPublishViewController.h"
#import "YGPostWordViewController.h"  // 为了调试方便

@interface YGTabBar ()
/**
 *  发布按钮
 */
@property (weak, nonatomic) UIButton *publishButton;
@end

@implementation YGTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        // 添加发布按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.publishButton = button;
    }
    
    return self;
}
/**
 *  发布按钮点击
 */
- (void)publishClick
{
//    YGPublishViewController *publish = [[YGPublishViewController alloc] init];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:YES completion:nil];
    
    YGPostWordViewController *pWordVc = [[YGPostWordViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:pWordVc];
    // 根控制器
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVc presentViewController:nav animated:YES completion:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 标记按钮是否已经添加过监听
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // 设置发布按钮的frame
    self.publishButton.frame = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    
    NSInteger i = 0;
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = ((i>1)? (i +1):i )* buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        i++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(pubBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    added = YES;
}

- (void)pubBtnClick
{
    // 发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YGTarBarDidSelectedNotification object:nil userInfo:nil];
}


@end
