//
//  YGPlaceholderView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPlaceholderView.h"

@implementation YGPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        // 默认占位文字颜色
        self.placeholderColor = [UIColor lightGrayColor];
        
        // 监听自己的文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textDidChange
{
    [self setNeedsDisplay];
}
/**
 *  绘制占位文字
 */
- (void)drawRect:(CGRect)rect {
    // 如果有文字直接返回，不绘制占位文字
    if (self.hasText) return;
    
    rect.origin.x = 3;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:rect withAttributes:attrs];
}
#pragma mark - 重写stter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay]; // 重写绘制

}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = [placeholderColor copy];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

@end
