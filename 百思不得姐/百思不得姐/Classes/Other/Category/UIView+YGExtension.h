//
//  UIView+YGExtension.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YGExtension)
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
/**
 *  判断一个控件是否真正显示在窗口上
 */
- (BOOL)isShowingOnWindow;

+ (instancetype)viewFromXib;
@end
