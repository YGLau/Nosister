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

@end

@implementation YGCommentCell

- (void)setComment:(YGComment *)comment
{
    _comment = comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sex.image = [comment.user.sex isEqualToString:YGUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.cmtContent.text = comment.content;
    self.userName.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    
    
}

@end
