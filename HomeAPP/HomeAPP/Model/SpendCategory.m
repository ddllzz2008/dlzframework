//
//  SpendCategory.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "SpendCategory.h"

@implementation SpendCategory

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"CID":@"CID",
             @"SNAME":@"CNAME",
             @"SVALUE":@"EVALUE",
             @"COLOR":@"CCOLOR",};
}

@end
