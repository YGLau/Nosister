//
//  YGTagTextfiled.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/8.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTagTextfiled.h"

@implementation YGTagTextfiled

- (void)deleteBackward
{
    
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"多个标签逗号或回车分隔";
        self.font = [UIFont systemFontOfSize:15];
    }
    
    return self;
}

@end
