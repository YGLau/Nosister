//
//  UIBarButtonItem+YGExtension.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/15.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YGExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
