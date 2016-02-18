//
//  YGRecommendTag.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGRecommendTag : NSObject
/**
*  图片
*/
@property (copy, nonatomic) NSString *image_list;
/**
 *  名称
 */
@property (copy, nonatomic) NSString *theme_name;
/**
 *  订阅数
 */
@property (assign, nonatomic) NSInteger sub_number;
@end
