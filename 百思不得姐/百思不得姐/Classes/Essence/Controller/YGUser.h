//
//  YGUser.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGUser : NSObject
/**
 *  用户名
 */
@property (copy, nonatomic) NSString *username;
/**
 *  性别
 */
@property (copy, nonatomic) NSString *sex;
/**
 *  头像
 */
@property (copy, nonatomic) NSString *profile_image;

@end
