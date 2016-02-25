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


@end


@implementation YGTopicCell

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
    
    [self setButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.repostBtn count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
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
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}

@end
