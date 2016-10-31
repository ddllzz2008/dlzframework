//
//  NSString+ExtMethod.m
//  DLZHelpers
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "NSString+ExtMethod.h"

@implementation NSString (ExtMethod)

-(BOOL) isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/*
 *-------------------字符串转NSDate--------------------------------*
 *-------------------本月或上月点击中间内容无反应-------------------*
 */
- (NSDate*) convertDateFromString:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:self];
    return date;
}

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padLeftWithChar:(int)maxlength charstring:(NSString*)charstring
{
    NSInteger len = self.length;
    if (len >=maxlength) {
        return self;
    }else{
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        NSInteger dis = maxlength - len;
        for (int i = 0; i<dis; i++) {
            [mutableString appendString:charstring];
        }
        [mutableString appendString:self];
        return [mutableString copy];
    }
}

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padRightWithChar:(int)maxlength charstring:(NSString*)charstring
{
    NSInteger len = self.length;
    if (len >=maxlength) {
        return self;
    }else{
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        int dis = maxlength - len;
        [mutableString appendString:self];
        for (int i = 0; i<dis; i++) {
            [mutableString appendString:charstring];
        }
        return [mutableString copy];
    }
}

@end
