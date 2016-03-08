//
//  YGTagButton.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/8.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTagButton.h"

@implementation YGTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = YGTagBg;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // label位置
    self.titleLabel.x = YGTagMargin;
   
    // 图片文字
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + YGTagMargin;
    
    
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * YGTagMargin;
}

@end
