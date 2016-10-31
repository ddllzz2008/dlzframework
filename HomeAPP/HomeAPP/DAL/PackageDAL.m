//
//  PackageDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "PackageDAL.h"

@implementation PackageDAL

static PackageDAL *instance = nil;

+(PackageDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/*
 *-----------查询钱包-------------*
 */
-(NSMutableArray*)getPackageCompare{
    NSString *sql = @" SELECT PID,PNAME,PVALUE,PCOLOR,PORDER FROM BASE_PACKAGE WHERE ISVALID=1 ORDER BY PORDER ASC ";
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *packages = [MTLJSONAdapter modelsOfClass:[PackageCompare class] fromJSONArray:array error:nil];
    return [packages mutableCopy];
}

/*
 *-----------添加钱包-------------*
 */
-(PackageCompare *)addPackage:(NSString *)pname pvalue:(double)pvalue pcolor:(NSString *)pcolor{
    int order = 0;
    NSString *sqlMax = @"SELECT MAX(PORDER) AS MAXORDER FROM BASE_PACKAGE";
    NSMutableArray *maxArray = [[FmdbHelper Instance] querySql:sqlMax];
    if (maxArray!=nil && maxArray.count>0) {
        id maxValue = [[maxArray objectAtIndex:0] objectForKey:@"MAXORDER"];
        if ([maxValue isEqual:[NSNull null]]) {
            order = 0;
        }else{
            order = [maxValue intValue] + 1;
        }
    }
    NSString *guid = [CommonFunc NewGUID];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BASE_PACKAGE(PID,PNAME,PVALUE,PCOLOR,PORDER) VALUES('%@','%@',%lf,'%@',%d)",guid,pname,pvalue,pcolor,order];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    
    if (state) {
        PackageCompare *model = [PackageCompare new];
        model.PID = guid;
        model.PNAME = pname;
        model.PVALUE = pvalue;
        model.PSORT =order;
        model.PCOLOR = pcolor;
        return model;
    }
    else{
        return nil;
    }
}

/*
 *-----------修改钱包-------------*
 */
-(BOOL)updatePackage:(NSString*)pid pname:(NSString *)pname pvalue:(double)pvalue pcolor:(NSString *)pcolor{
    NSString *sql = [NSString stringWithFormat:@"UPDATE BASE_PACKAGE SET PNAME='%@',PVALUE=%f,PCOLOR='%@' WHERE PID='%@'",pname,pvalue,pcolor,pid];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    
    return state;
}

/*
 *-----------删除钱包-------------*
 */
-(BOOL)deletePackage:(NSString*)pid{
    NSString *sql = [NSString stringWithFormat:@"UPDATE BASE_PACKAGE SET ISVALID=0 WHERE PID='%@'",pid];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    
    return state;
}

/*
 *-----------排序钱包-------------*
 */
-(BOOL)sortPackage:(PackageCompare*)p1 p2:(PackageCompare*)p2{
    NSString *sql1 = [NSString stringWithFormat:@"UPDATE BASE_PACKAGE SET PORDER=%D WHERE PID='%@'",p1.PSORT,p1.PID];
    NSString *sql2 = [NSString stringWithFormat:@"UPDATE BASE_PACKAGE SET PORDER=%D WHERE PID='%@'",p2.PSORT,p2.PID];
    NSArray *array = [NSArray arrayWithObjects:sql1,sql2, nil];
    BOOL state = [[FmdbHelper Instance] executeSqlWithTransaction:array];
    
    return state;
}

@end
