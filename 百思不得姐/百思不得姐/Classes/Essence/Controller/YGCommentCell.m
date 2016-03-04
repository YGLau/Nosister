//
//  YGCommentCell.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGCommentCell.h"
#import "YGComment.h"
#import <UIImageView+WebCache.h>
#import "YGUser.h"

@interface YGCommentCell ()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  性别
 */
@property (weak, nonatomic) IBOutlet UIImageView *sex;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/**
 *  评论内容
 */
@property (weak, nonatomic) IBOutlet UILabel *cmtContent;
/**
 *  赞数
 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end

@implementation YGCommentCell

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)setComment:(YGComment *)comment
{
    _comment = comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sex.image = [comment.user.sex isEqualToString:YGUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.cmtContent.text = comment.content;
    self.userName.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];

    if (comment.voiceuri.length) {
        self.voiceBtn.hidden = NO;
        [self.voiceBtn setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
        
    } else {
        self.voiceBtn.hidden = YES;
    }
    
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = YGTopicCellMargin;
    frame.size.width -= 2 * YGTopicCellMargin;
    
    [super setFrame:frame];
}

-(void)awakeFromNib
{
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bg;
}

@end
