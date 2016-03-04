//
//  YGTopWindow.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/4.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTopWindow.h"

@implementation YGTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, YGmainScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}
+ (void)show
{
    
    window_.hidden = NO;
}

+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
    
}

+ (void)searchScrollViewInView:(UIView *)supView
{
    for (UIScrollView *subview in supView.subviews) {
        
        // 如果是UIScrollView，滚动到最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续遍历子控件
        [self searchScrollViewInView:subview];
    }
}
@end
