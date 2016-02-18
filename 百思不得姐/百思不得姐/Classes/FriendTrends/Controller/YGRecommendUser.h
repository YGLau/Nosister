//
//  RecommendUser.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGRecommendUser : NSObject

/**
 *  头像
 */
@property (copy, nonatomic) NSString *header;

/**
 *  粉丝数
 */
@property (assign, nonatomic) NSInteger fans_count;

/**
 *  昵称
 */
@property (copy, nonatomic) NSString *screen_name;
@end
