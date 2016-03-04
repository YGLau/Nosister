//
//  YGTopicCell.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTopicCell.h"
#import "YGTopic.h"
#import <UIImageView+WebCache.h>
#import "YGPictureView.h"
#import "YGVoiceView.h"
#import "YGVideoView.h"
#import "YGComment.h"
#import "YGUser.h"

@interface YGTopicCell ()

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profile_image;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabe;
/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**
 *  顶按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/**
 *  踩按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/**
 *  分享按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
/**
 *  评论按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/**
 *  文字内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/**
 *  图片帖子中间的View
 */
@property (weak, nonatomic) YGPictureView *picView;

/**
 *  声音帖子中间的View
 */
@property (weak, nonatomic) YGVoiceView *voiceView;

/**
 *  视频帖子中间的View
 */
@property (weak, nonatomic) YGVideoView *videoView;
/**
 *  最热评论
 */
@property (weak, nonatomic) IBOutlet UIView *commentLabel;
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *cmtcontentLabel;
@end


@implementation YGTopicCell
+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


#pragma mark - 懒加载

- (YGPictureView *)picView
{
    if (!_picView) {
        YGPictureView *picView = [YGPictureView pictureView];
        [self.contentView addSubview:picView];
        _picView = picView;
    }
    
    return _picView;
}

- (YGVoiceView *)voiceView
{
    if (!_voiceView) {
        YGVoiceView *voiceView = [YGVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (YGVideoView *)videoView
{
    if (!_videoView) {
        YGVideoView *videoView = [YGVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
        
    }
    
    return _videoView;
}

#pragma mark - 初始化
-(void)awakeFromNib
{
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bg;
}

-(void)setFrame:(CGRect)frame
{
    
    frame.size.height = self.topic.cellHeight - YGTopicCellMargin;
    frame.origin.y += YGTopicCellMargin;
    
    [super setFrame:frame];
}
#pragma mark - 重写setter
-(void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    // 设置圆形头像
    [self.profile_image setCircleHeader:topic.profile_image];
    // 昵称
    self.nicknameLabe.text = topic.name;
    // 发帖时间
    self.createTimeLabel.text = topic.create_time;
    // 文字内容
    self.contentLabel.text = topic.text;
    
    [self setButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.repostBtn count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
    
    // 根据模型的内容，将对应的内容添加到Cell中
    if (topic.type == YGBaseTopicTypePicture) { // 图片
        self.picView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.picView.topic = topic; // 将topic模型传递给图片view的topic模型
        self.picView.frame = topic.picFrame;
        
    } else if (topic.type == YGBaseTopicTypeVoice) {  // 声音
        self.picView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic; // 拿到数据
        self.voiceView.frame = topic.voiceF; // 将算好的frame传给voiceView
        
    } else if (topic.type == YGBaseTopicTypeVideo) { // 视频
        self.picView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        
    } else if (topic.type == YGBaseTopicTypeWord) {
        self.picView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }
    
    // 处理最热评论
    YGComment *cmt = [topic.top_cmt firstObject];
    if (cmt) {
        self.commentLabel.hidden = NO;
        self.cmtcontentLabel.text = [NSString stringWithFormat:@"%@ : %@",cmt.user.username, cmt.content];
    } else {
        self.commentLabel.hidden = YES;
    }
    
}

- (void)setButtonTitle:(UIButton *)buttton count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0 ) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [buttton setTitle:placeholder forState:UIControlStateNormal];
}
/**
 *  更多
 */
- (IBAction)more {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
}



@end
