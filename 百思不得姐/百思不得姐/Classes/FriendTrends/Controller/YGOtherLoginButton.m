//
//  YGOtherLoginButton.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/20.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGOtherLoginButton.h"

@implementation YGOtherLoginButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    
}
/**
 *  通过xib创建，重写这个方法
 */
-(void)awakeFromNib
{
    [self setup];
}
/**
 *  通过代码创建重写这个方法
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = 72;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

@end
