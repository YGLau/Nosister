//
//  YGPlaceholderView.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGPlaceholderView : UITextView
/**
 *  占位文字
 */
@property (weak, nonatomic) NSString *placeholder;
/**
 *  占位文字颜色
 */
@property (strong, nonatomic) UIColor *placeholderColor;

@end
