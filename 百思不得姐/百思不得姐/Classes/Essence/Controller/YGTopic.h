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
@property (copy, nonatomic) NSString *create_time;
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
/**
 *  图片的高度
 */
@property (assign, nonatomic) CGFloat height;
/**
 *  图片的宽度
 */
@property (assign, nonatomic) CGFloat width;

/**
 *  大图
 */
@property (copy, nonatomic) NSString *large_image;
/**
 *  中图
 */
@property (copy, nonatomic) NSString *meddle_image;
/**
 *  小图
 */
@property (copy, nonatomic) NSString *small_image;
/**
 *  段子的类型
 */
@property (assign, nonatomic) YGBaseTopicType type;
/*** **************/
/**
 *  Cell的高度
 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;
/**
 *  图片控件的frame
 */
@property (assign, nonatomic, readonly) CGRect picFrame;


@end
