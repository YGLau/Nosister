//
//  YGRecommendCategroy.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/17.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGRecommendCategroy : NSObject
/**
 *  id
 */
@property (assign, nonatomic) NSInteger id;
/**
 *  总数
 */
@property (assign, nonatomic) NSInteger count;
/**
 *  名字
 */
@property (copy, nonatomic) NSString *name;

/**
 *  这个类别对应的用户数据
 */
@property (strong, nonatomic) NSMutableArray *users;

/**
 *  总数
 */
@property (assign, nonatomic) NSInteger total;
/**
 *  当前页码
 */
@property (assign, nonatomic) NSInteger current_page;
@end
