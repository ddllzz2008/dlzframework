//
//  NSDate+ExtMethod.m
//  DLZHelpers
//
//  Created by ddllzz on 16/4/8.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "NSDate+ExtMethod.h"

@implementation NSDate (ExtMethod)

/**
 * 格式化日期
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSString *)formatWithCode:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:self];
}

/**
 * 获取当前星期范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForCurrentWeek{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self]weekday];
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    [components setDay:([components day]+(7-dayofweek)+1)];// for end day of the week
    NSDate *enddingOfWeek = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginningOfWeek,enddingOfWeek,nil];
    
    return weekArray;
}

/**
 * 获取上星期范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForLastWeek{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self]weekday];
    [components setDay:([components day] - ((dayofweek) - 2) - 7)];// for beginning of the week.
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    [components setDay:([components day]+(7-dayofweek)+1 - 7)];// for end day of the week
    NSDate *enddingOfWeek = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginningOfWeek,enddingOfWeek,nil];
    
    return weekArray;
}

/**
 * 获取本月范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForCurrentMonth{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    double interval = 0;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:self];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        
    }
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取本月范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForLastMonth{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    double interval = 0;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    [components setMonth:([components month] - 1)];
    
    NSDate *lastMonth = [gregorian dateFromComponents:components];
    
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:lastMonth];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        
    }
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取下月范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForNextMonth{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    double interval = 0;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    [components setMonth:([components month] + 1)];
    
    NSDate *lastMonth = [gregorian dateFromComponents:components];
    
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:lastMonth];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        
    }
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取本年范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForCurrentYear{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:dateComponents.year];
    [components setMonth:1];
    [components setDay:1];
    
    beginDate = [gregorian dateFromComponents:components];
    
    [components setYear:dateComponents.year];
    [components setMonth:12];
    [components setDay:31];
    
    endDate = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取本年范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForLastYear{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:dateComponents.year-1];
    [components setMonth:1];
    [components setDay:1];
    
    beginDate = [gregorian dateFromComponents:components];
    
    [components setYear:dateComponents.year-1];
    [components setMonth:12];
    [components setDay:31];
    
    endDate = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取明年范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForNextYear{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:dateComponents.year+1];
    [components setMonth:1];
    [components setDay:1];
    
    beginDate = [gregorian dateFromComponents:components];
    
    [components setYear:dateComponents.year-1];
    [components setMonth:12];
    [components setDay:31];
    
    endDate = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取对应天数间隔的日期
 * @days 相隔天数
 * @return 固定的日期
 */
-(NSDate *)dateForDays:(NSInteger)days{
    NSDate *resultDay = [self initWithTimeIntervalSinceNow:(days * 24 * 60 * 60)];
    return resultDay;
}

/**
 * 获取对应天数间隔的日期
 * @days 相隔天数
 * @return 固定的日期
 */
+(NSDate *)dateForDays:(NSInteger)days{
    NSDate *resultDay = [NSDate dateWithTimeIntervalSinceNow:(days * 24 * 60 * 60)];
    return resultDay;
}

@end
