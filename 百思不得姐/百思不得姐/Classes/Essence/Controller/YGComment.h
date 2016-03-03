//
//  YGComment.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YGUser;

@interface YGComment : NSObject
/**
 *  帖子ID
 */
@property (copy, nonatomic) NSString *ID;
/**
 *  音频播放时长
 */
@property (assign, nonatomic) NSInteger voicetime;
/**
 *  音频文件的路径
 */
@property (copy, nonatomic) NSString *voiceuri;
/**
 *  点赞数
 */
@property (assign, nonatomic) NSInteger like_count;
/**
 *  评论内容
 */
@property (copy, nonatomic) NSString *content;
/**
 *  用户模型
 */
@property (strong, nonatomic) YGUser *user;

@end
