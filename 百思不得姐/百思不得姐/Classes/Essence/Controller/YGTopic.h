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
 *  段子的类型
 */
@property (assign, nonatomic) YGBaseTopicType type;
/**
 *  Cell的高度
 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;

/** 图片的下载进度值 */
@property (assign, nonatomic) CGFloat pictureProgress;

/***************** 图片 **************/

/**
 *  大图 -  声音 图片 视频 - 共用图片
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
 *  图片的高度
 */
@property (assign, nonatomic) CGFloat height;
/**
 *  图片的宽度
 */
@property (assign, nonatomic) CGFloat width;
/**
 *  图片控件的frame
 */
@property (assign, nonatomic, readonly) CGRect picFrame;

@property (assign, nonatomic,getter=isGif) BOOL is_gif;

/***************** 声音 **************/
/**
 *  声音时长
 */
@property (assign, nonatomic) NSInteger voicetime;

/**
 *  播放次数 - 声音和视频 共用
 */
@property (assign, nonatomic) NSInteger playcount;
/**
 *  声音view的frame
 */
@property (assign, nonatomic, readonly) CGRect voiceF;

/***************** 视频 **************/

/**
 *  视频view的frame
 */
@property (assign, nonatomic, readonly) CGRect videoF;
/**
 *  视频时长
 */
@property (assign, nonatomic) NSInteger videotime;
/**
 *  是否为大图
 */
@property (assign, nonatomic, getter=isBigPicture) BOOL bigPicture;

@end
