//
//  YGTopic.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTopic.h"

@implementation YGTopic

- (NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createTime = [fmt dateFromString:_create_time];
    if (createTime.isThisYear) { // 今年
        NSDateComponents *cmps = [[NSDate date] deltaFrom:createTime];
        if (createTime.isToday) { // 今天
            if (cmps.hour >= 1) { // 至少间隔1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1){ //至少间隔1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
            
        } else if(createTime.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createTime];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createTime];
        }
    } else { // 去年
        return _create_time;
    }
}

@end
