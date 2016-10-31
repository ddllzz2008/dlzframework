//
//  NSDate+ExtMethod.h
//  DLZHelpers
//
//  Created by ddllzz on 16/4/8.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ExtMethod)

- (NSString*) formatWithCode:(NSString*)format;

- (NSArray *)dateForCurrentWeek;

- (NSArray *)dateForLastWeek;

- (NSArray *)dateForCurrentMonth;

- (NSArray *)dateForLastMonth;

- (NSArray *)dateForNextMonth;

- (NSArray *)dateForCurrentYear;

- (NSArray *)dateForLastYear;

- (NSArray *)dateForNextYear;

-(NSDate *)dateForDays:(NSInteger)days;

+(NSDate *)dateForDays:(NSInteger)days;

@end
