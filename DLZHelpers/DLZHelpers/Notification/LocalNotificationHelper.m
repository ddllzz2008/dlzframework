//
//  LocalNotificationHelper.m
//  DLZHelpers
//
//  Created by ddllzz on 16/7/27.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "LocalNotificationHelper.h"

@implementation LocalNotificationHelper

#define LOCAL_NOTIFY_SCHEDULE_ID @"localNotificationID"

/*
开始本地通知
type:通知间隔，0:每天，1:每周，2:每月
weekday:每周几或每月几号
hour:通知小时
minute:通知分钟
body:显示文本
acction:显示按钮名称
*/
+(BOOL)startLocalNotification:(NSString*)rid type:(NSInteger)type weekday:(NSInteger)weekday hour:(NSString*)hour minute:(NSString*)minute body:(NSString*)body action:(NSString*)action{
//    kCFCalendarUnitWeekday
    BOOL result = YES;
    @try {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        NSDate *now = [NSDate date];
        NSDate *fireDate =nil;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comp1 = [[NSDateComponents alloc] init];
        NSDateComponents *comp2 = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        comp1 = [calendar components:unitFlags fromDate:now];
        /*初始化时间*/
        NSString *year = [[NSString stringWithFormat:@"%d",comp1.year] padLeftWithChar:4 charstring:@"0"];
        NSString *month = [[NSString stringWithFormat:@"%d",comp1.month] padLeftWithChar:2 charstring:@"0"];
        NSString *day = [[NSString stringWithFormat:@"%d",comp1.day] padLeftWithChar:2 charstring:@"0"];
        hour = [[NSString stringWithFormat:@"%@",hour] padLeftWithChar:2 charstring:@"0"];
        minute = [[NSString stringWithFormat:@"%@",minute] padLeftWithChar:2 charstring:@"0"];
        
        
        NSString *targetDateString = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:00",year,month,day,hour,minute];
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
        [dateFormater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *targetDate = [dateFormater dateFromString:targetDateString];
        /*---end---*/
        comp2 = [calendar components:unitFlags fromDate:targetDate];
        switch (type) {
            case 0:
            {
                BOOL isLater = NO;
                if (comp2.hour>comp1.hour) {
                    isLater = YES;
                }else if (comp2.hour==comp1.hour){
                    if (comp2.minute>comp1.minute) {
                        isLater = YES;
                    }
                }
                if (isLater) {
                    fireDate = targetDate;
                }else{
                    fireDate = [targetDate dateForDays:1];
                }
                localNotification.repeatInterval=NSCalendarUnitDay;
            }
                break;
            case 1:
            {
                if (weekday>comp1.weekday) {
                    fireDate = [targetDate dateForDays:(weekday-comp1.weekday)];
                }else if (weekday==comp1.weekday){
                    fireDate = targetDate;
                }else{
                    fireDate = [targetDate dateForDays:(7-(comp1.weekday - weekday))];
                }
                localNotification.repeatInterval=NSCalendarUnitWeekday;
            }
                break;
            case 2:
            {
                if (weekday>comp1.day) {
                    fireDate = [targetDate dateForDays:(weekday-comp1.day)];
                }else if (weekday==comp1.day){
                    fireDate = targetDate;
                }else{
                    [comp1 setYear:0];
                    
                    [comp1 setMonth:1];
                    
                    [comp1 setDay:(weekday - comp1.day)];
                    
                    fireDate = [calendar dateByAddingComponents:comp1 toDate:now options:0];
                }
                localNotification.repeatInterval=NSCalendarUnitMonth;
            }
                break;
            default:
                fireDate = now;
                break;
        }
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.fireDate = fireDate;
        localNotification.alertBody = body;
        localNotification.alertAction = action;
        // 通知被触发时播放的声音
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        // ios8后，需要添加这个注册，才能得到授权
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                     categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            // 通知重复提示的单位，可以是天、周、月
//            localNotification.repeatInterval = NSCalendarUnitDay;
        } else {
            // 通知重复提示的单位，可以是天、周、月
//            localNotification.repeatInterval = NSDayCalendarUnit;
        }
        
        //给本地通知添加备注信息
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@_%@",LOCAL_NOTIFY_SCHEDULE_ID,rid],@"id", nil];
        localNotification.userInfo = dic;
        
        // 执行通知注册
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
    @catch (NSException *exception) {
        result = NO;
        DDLogDebug(@"调用方法LocalNotificationHelper.startLocalNotification失败,原因:%@",exception);
    }
    @finally {
        return result;
    }
}

+(void)deleteLocalNotification:(NSString*)rid{
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //获取本地所有的通知
    if (!array || array.count <=0) {
        return;
    }
    for (UILocalNotification *notification in array) {
        if ([[notification.userInfo objectForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%@_%@",LOCAL_NOTIFY_SCHEDULE_ID,rid]]) {
            //取消某个特定的通知
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            break;
        }
    }
}

+(void)deleteAllNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
