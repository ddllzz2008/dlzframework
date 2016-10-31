//
//  LocalNotificationHelper.h
//  DLZHelpers
//
//  Created by ddllzz on 16/7/27.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ExtMethod.h"
#import "NSDate+ExtMethod.h"

@interface LocalNotificationHelper : NSObject

+(BOOL)startLocalNotification:(NSInteger)type weekday:(NSInteger)weekday hour:(NSString*)hour minute:(NSString*)minute body:(NSString*)body action:(NSString*)action;

+(void)deleteLocalNotification:(NSString*)rid;

+(void)deleteAllNotification;

@end
