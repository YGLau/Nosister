//
//  YGTextField.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/20.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTextField.h"
#import <objc/runtime.h>

@implementation YGTextField

-(void)awakeFromNib
{
//    [self setValue:[UIColor grayColor] forKey:@"_placeholderLabel"];
//    UILabel *placeholderLabel = [self valueForKey:@"_placeholderLabel"];
//    placeholderLabel.textColor = [UIColor grayColor];
    [self resignFirstResponder];
    self.tintColor = self.textColor;
    
}
/**
 *  成为第一响应者
 */
-(BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"]; // 聚焦时，文字变成白色
    
    return [super becomeFirstResponder];
}

/**
 *  不成为第一响应者
 */
-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"]; // 失去焦点时文字变为灰色
    return [super resignFirstResponder];
}
@end
