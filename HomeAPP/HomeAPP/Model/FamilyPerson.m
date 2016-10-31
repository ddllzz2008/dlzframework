//
//  FamilyPerson.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/22.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "FamilyPerson.h"

@implementation FamilyPerson

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"fid":@"FID",
             @"fname":@"FNAME",
             @"fsort":@"FSORT",
             @"createtime":@"CREATETIME",
             @"isedit":@"ISEDIT",};
}

@end
