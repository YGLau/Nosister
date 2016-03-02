//
//  YGProgressView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/2.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGProgressView.h"

@implementation YGProgressView


- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f", progress * 100];
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.text = text;
}
@end
