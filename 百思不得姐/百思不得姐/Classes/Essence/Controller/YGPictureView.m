//
//  YGPictureView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/26.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPictureView.h"
#import "YGTopic.h"
#import <UIImageView+WebCache.h>

@interface YGPictureView ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
/**
 *  是否会gif
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**
 *  查看大图
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicBtn;

@end
@implementation YGPictureView
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

-(void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
}
@end
