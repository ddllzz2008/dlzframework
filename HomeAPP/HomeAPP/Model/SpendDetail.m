//
//  SpendDetail.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/5.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "SpendDetail.h"

@implementation SpendDetail

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"EID":@"EID",
             @"PID":@"PID",
             @"EVALUE":@"EVALUE",
             @"CREATETIME":@"CREATETIME",
             @"IMARK":@"IMARK",
             @"PNAME":@"PNAME",
             @"PCOLOR":@"PCOLOR"};
}

@end
