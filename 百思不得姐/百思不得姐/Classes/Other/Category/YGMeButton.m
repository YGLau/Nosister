//
//  YGMeButton.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/5.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGMeButton.h"
#import "YGSquare.h"
#import <UIButton+WebCache.h>

@implementation YGMeButton

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 图片
    
    
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX =self.width * 0.5;
    
    // 文字
    self.titleLabel.x = 0;
    self.titleLabel.y =CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)setSquare:(YGSquare *)Square
{
    _Square = Square;
    [self setTitle:Square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:Square.icon] forState:UIControlStateNormal];
}
@end
