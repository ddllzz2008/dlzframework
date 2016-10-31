//
//  Common.h
//  Bingo
//
//  Created by lifc on 15-5-9.
//  Copyright (c) 2015年 lifc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface CommonFunc : NSObject

#pragma 时间类方法
+(NSString *)getCurrentDate;
+(NSString *)getCurrentDateWithFormat:(NSString *)format;

#pragma 加密类方法
+(NSString *)md5HexDigest:(NSString*)str;

#pragma 字符串类方法
+(BOOL) isBlankString:(NSString *)string;
//版本号比较
+(BOOL)version:(NSString *)_oldver lessthan:(NSString *)_newver;
//生成GUID
+(NSString *)NewGUID;
+(BOOL)isValidateMobile:(NSString*)mobile;
@end
