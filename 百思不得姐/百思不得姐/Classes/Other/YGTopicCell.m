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


@end


@implementation YGTopicCell

-(YGPictureView *)picView
{
    if (!_picView) {
        YGPictureView *picView = [YGPictureView pictureView];
        [self.contentView addSubview:picView];
        _picView = picView;
    }
    
    return _picView;
}



-(void)awakeFromNib
{
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bg;
}

-(void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    // 设置头像
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
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
    if (topic.type == YGBaseTopicTypePicture) {
        self.picView.topic = topic; // 将topic模型传递给图片view的topic模型
        self.picView.frame = topic.picFrame;
    }
    
    
}

- (void)setButtonTitle:(UIButton *)buttton count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@".1%f万",count / 10000.0];
    } else if (count > 0 ) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [buttton setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = YGTopicCellMargin;
    frame.size.width -= 2 * YGTopicCellMargin;
    frame.size.height -= YGTopicCellMargin;
    frame.origin.y += YGTopicCellMargin;
    [super setFrame:frame];
}

@end
