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

@interface YGVoiceView ()
/**
 *  声音背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *VoiceBgPic;
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


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}
/**
 *  setter
 */
- (void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    // 设置图片
    [self.VoiceBgPic sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
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
