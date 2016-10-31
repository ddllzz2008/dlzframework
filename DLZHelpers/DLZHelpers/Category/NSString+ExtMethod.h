//
//  NSString+ExtMethod.h
//  DLZHelpers
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ExtMethod)

-(BOOL) isBlankString;

- (NSDate*) convertDateFromString:(NSString *)format;

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padLeftWithChar:(int)maxlength charstring:(NSString*)charstring;

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padRightWithChar:(int)maxlength charstring:(NSString*)charstring;

@end
