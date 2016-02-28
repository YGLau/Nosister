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

@interface YGVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *videoBgView;

@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;

@end

@implementation YGVideoView

+ (instancetype)videoView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
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
