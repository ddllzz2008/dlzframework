//
//  PackageCompare.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "PackageCompare.h"

@implementation PackageCompare

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"PID":@"PID",
             @"PNAME":@"PNAME",
             @"PVALUE":@"PVALUE",
             @"PCOMPAREVALUE":@"PCOMPAREVALUE",
             @"PSORT":@"PORDER",
             @"PCOLOR":@"PCOLOR",
             @"ISVALID":@"ISVALID",};
}

@end
