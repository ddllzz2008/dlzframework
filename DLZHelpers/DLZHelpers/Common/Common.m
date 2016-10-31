//
//  Common.m
//  Bingo
//
//  Created by lifc on 15-5-9.
//  Copyright (c) 2015年 lifc. All rights reserved.
//

#import "Common.h"

@implementation CommonFunc

#pragma mark 时间类方法

+(NSString *)getCurrentDate{
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}

+(NSString *)getCurrentDateWithFormat:(NSString *)format{
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:format];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    return locationString;
}

#pragma mark 加密类方法
+(NSString *)md5HexDigest:(NSString*)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    //LOG(@"Encryption Result = %@",mdfiveString);
    return mdfiveString;
}

#pragma mark 字符串类方法
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//版本号比较
+(BOOL)version:(NSString *)_oldver lessthan:(NSString *)_newver
{
    NSArray *a1 = [_oldver componentsSeparatedByString:@"."];
    NSArray *a2 = [_newver componentsSeparatedByString:@"."];
    
    for (int i = 0; i < [a1 count]; i++) {
        if ([a2 count] > i) {
            if ([[a1 objectAtIndex:i] floatValue] < [[a2 objectAtIndex:i] floatValue]) {
                return YES;
            }
            else if ([[a1 objectAtIndex:i] floatValue] > [[a2 objectAtIndex:i] floatValue])
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    return [a1 count] < [a2 count];
}

//生成GUID
+(NSString *)NewGUID
{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    
    CFRelease(uuid_string_ref);
    
    return uuid;
    
}
//判断是否电话号码
+(BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
@end
