//
//  UIImageView+YGExtension.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/4.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "UIImageView+YGExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (YGExtension)

- (void)setCircleHeader:(NSString *)url
{
    // 设置头像
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}

@end
