//
//  FamilyPersonDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/22.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "FamilyPersonDAL.h"

@implementation FamilyPersonDAL

static FamilyPersonDAL *instance = nil;

+(FamilyPersonDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/*
 *-------------获取家庭成员列表------------------*
 */
-(NSArray*)getFamilyPersons{
    NSString *sql = @" SELECT FID,FNAME,FSORT,CREATETIME,ISEDIT FROM BASE_FAMILY ORDER BY FSORT ";
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[FamilyPerson class] fromJSONArray:array error:nil];
    return result;
}

@end
