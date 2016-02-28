//
//  YGVoiceView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/27.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGVoiceView.h"
#import <UIImageView+WebCache.h>
#import "YGTopic.h"
#import "YGBigPictureController.h"


@interface YGVoiceView ()
/**
 *  声音背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *voiceBgPic;
/**
 *  播放次数
 */
@property (weak, nonatomic) IBOutlet UILabel *playTimes;
/**
 *  声音时长
 */
@property (weak, nonatomic) IBOutlet UILabel *voiceLength;

@end

@implementation YGVoiceView

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
    self.voiceBgPic.userInteractionEnabled = YES;
    [self.voiceBgPic addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)]];

}
/**
 *  setter
 */
- (void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    // 设置图片
    [self.voiceBgPic sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    // 设置播放次数
    self.playTimes.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    // 设置时长
    NSInteger second = topic.voicetime % 60;
    NSInteger minute = topic.voicetime / 60;
    self.voiceLength.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    
}


+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
