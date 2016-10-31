//
//  MonitorApplication.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/25.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MonitorApplication.h"

@implementation MonitorApplication

+(NSString *)getNotificationObserKey{
    return @"notiScreenTouch";
}

-(void)sendEvent:(UIEvent *)event{
    if (event.type==UIEventTypeTouches) {
        if ([[[event allTouches] anyObject] phase]==UITouchPhaseBegan) {
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"notiScreenTouch" object:nil userInfo:[NSDictionary dictionaryWithObject:event forKey:@"data"]]];
        }
    }
    [super sendEvent:event];
}

@end
