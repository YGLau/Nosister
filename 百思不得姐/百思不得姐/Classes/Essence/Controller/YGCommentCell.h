//
//  YGCommentCell.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGComment;

@interface YGCommentCell : UITableViewCell
/**
 *  评论模型
 */
@property (strong, nonatomic) YGComment *comment;

@end
