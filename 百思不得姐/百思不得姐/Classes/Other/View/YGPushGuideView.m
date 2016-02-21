//
//  YGPushGuideView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/21.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPushGuideView.h"

@implementation YGPushGuideView

- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

/**
 *  返回一个创建好的UIView
 */
+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
/**
 *  显示引导指南
 */
+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window= [UIApplication sharedApplication].keyWindow;
        YGPushGuideView *guide = [YGPushGuideView guideView];
        guide.frame = window.frame;
        [window addSubview:guide];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立即同步
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


@end
