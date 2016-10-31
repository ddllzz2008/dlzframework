//
//  RemindModel.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/25.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "RemindModel.h"

@implementation RemindModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"RID":@"RID",
             @"REMARK":@"REMARK",
             @"RTIME":@"RTIME",
             @"RTYPE":@"RTYPE",
             @"STATUS":@"STATUS",
             @"RDAY":@"RDAY",};
}

@end
