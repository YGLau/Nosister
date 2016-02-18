//
//  YGRecommendCategroy.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/17.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGRecommendCategroy.h"

@implementation YGRecommendCategroy

-(NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end
