//
//  YGPlaceholderView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPlaceholderView.h"

@interface YGPlaceholderView ()
/**
 *  占位文字Label
 */
@property (weak, nonatomic) UILabel *phLabel;

@end

@implementation YGPlaceholderView

- (UILabel *)phLabel
{
    if (!_phLabel) {
        UILabel *phLabel = [[UILabel alloc] init];
        phLabel.numberOfLines = 0; // 文字换行
        phLabel.x = 4;
        phLabel.y = 7;
        [self addSubview:phLabel];
        self.phLabel = phLabel;
    }
    
    return _phLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 永远在竖直方向上有弹簧效果
        self.alwaysBounceVertical = YES;
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        // 默认占位文字颜色
        self.placeholderColor = [UIColor lightGrayColor];
        
        // 监听自己的文字改变通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}


/**
 *  更新label的尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = CGSizeMake(self.width - 2 * self.phLabel.x, MAXFLOAT);
    self.phLabel.size = [self.placeholder boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)textDidChange
{
    // 有文字就隐藏
    self.phLabel.hidden = self.hasText;
}

#pragma mark - 重写stter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.phLabel.text = placeholder;
    
    // 更新文字尺寸
    [self setNeedsLayout];

}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = [placeholderColor copy];
    self.phLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.phLabel.font = font;
    // 更新文字尺寸
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

@end
