//
//  BusExpenditure.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/17.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BusExpenditure.h"

@implementation BusExpenditure

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"EID":@"EID",
             @"EVALUE":@"EVALUE",
             @"CID":@"CID",
             @"FID":@"FID",
             @"PID":@"PID",
             @"CREATETIME":@"CREATETIME",
             @"EYEAR":@"EYEAR",
             @"EMONTH":@"EMONTH",
             @"EDAY":@"EDAY",
             @"IMARK":@"IMARK",};
}

@end
