//
//  CategoryModel.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"CID":@"CID",
             @"CNAME":@"CNAME",
             @"CCODE":@"CCODE",
             @"CPARENTCODE":@"CPARENTCODE",
             @"CSORT":@"CSORT",
             @"CREATETIME":@"CREATETIME",
             @"ISVALID":@"ISVALID",
             @"CCOLOR":@"CCOLOR",
             @"CTYPE":@"CTYPE",};
}

@end
