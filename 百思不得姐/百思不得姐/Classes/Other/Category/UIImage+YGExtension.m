//
//  UIImage+YGExtension.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/4.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "UIImage+YGExtension.h"

@implementation UIImage (YGExtension)

- (UIImage *)circleImage
{
    // NO代表不透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 开启图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将图片画上去
    [self drawInRect:rect];
    
    // 将图片画上去
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图形上下文
    UIGraphicsGetCurrentContext();
    
    return image;
}

@end
