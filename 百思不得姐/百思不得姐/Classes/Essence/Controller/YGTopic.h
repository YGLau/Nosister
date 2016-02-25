//
//  YGTopic.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGTopic : NSObject
/**
 *  昵称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  发帖时间
 */
@property (copy, nonatomic) NSString *creatTime;
/**
 *  头像
 */
@property (copy, nonatomic) NSString *profile_image;
/**
 *  段子内容
 */
@property (copy, nonatomic) NSString *text;
/**
 *  顶的数量
 */
@property (assign, nonatomic) NSInteger ding;
/**
 *  踩的数量
 */
@property (assign, nonatomic) NSInteger cai;
/**
 *  分享数量
 */
@property (assign, nonatomic) NSInteger repost;
/**
 *  评论数量
 */
@property (assign, nonatomic) NSInteger comment;


@end
