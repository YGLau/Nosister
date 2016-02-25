//
//  NSDate+Extension.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  从from时间到现在时间，返回一个间隔
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;
/**
 *  是否是今年
 */
- (BOOL)isThisYear;

/**
 *  是否今天
 */
- (BOOL)isToday;
/**
 *  是否昨天
 */
- (BOOL)isYesterday;

@end
