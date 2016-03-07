//
//  YGVideoView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/28.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGVideoView.h"
#import "YGTopic.h"
#import <UIImageView+WebCache.h>
#import "YGBigPictureController.h"

@interface YGVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *videoBgView;

@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;

@end

@implementation YGVideoView

- (void)showBigPicture
{
    YGBigPictureController *picVc = [[YGBigPictureController alloc] init];
    // 将模型数据传给控制器的topic模型
    picVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picVc animated:YES completion:nil];
}



- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.videoBgView.userInteractionEnabled = YES;
    [self.videoBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)]];
}
- (void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    [self.videoBgView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCount.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    NSInteger second = topic.videotime % 60;
    NSInteger minute = topic.videotime / 60;
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}


@end
