//
//  UIBarButtonItem+YGExtension.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/15.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "UIBarButtonItem+YGExtension.h"

@implementation UIBarButtonItem (YGExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end
