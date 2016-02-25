//
//  NSDate+Extension.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
     return [calender components:unit fromDate:from toDate:self options:0];

}


- (BOOL)isThisYear
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSInteger nowYear = [calender component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calender component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}
/**
 *  是否今天
 */
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSString *selfStr = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:selfStr];
}
/**
 *  是否昨天
 */
- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate= [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calender components:NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
    
}

@end
