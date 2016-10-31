//
//  ConvertHelper.m
//  DLZHelpers
//
//  Created by ddllzz on 16/3/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "ConvertHelper.h"

@implementation ConvertHelper

#pragma 颜色转换
+(UIColor *)convertToColor:(long)rgbValue{
    return [UIColor \
     colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
     green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
     blue:((float)(rgbValue & 0x0000FF))/255.0 \
            alpha:1.0];
}

@end
