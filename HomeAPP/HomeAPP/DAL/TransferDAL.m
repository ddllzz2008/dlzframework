//
//  TransferDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "TransferDAL.h"

@implementation TransferDAL

static TransferDAL *instance = nil;

+(TransferDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
/*
 *-------------添加转账记录------------------*
 */
-(BOOL)addTransfer:(NSString*)fromid toid:(NSString*)toid tvalue:(double)tvalue{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BUS_TRANSFER(ID,FROMPID,TOPID,TVALUE,ISVALID) VALUES('%@','%@','%@',%f,%d) ",[CommonFunc NewGUID],fromid,toid,tvalue,1];
    
    NSString *updatePackageSql1 = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE+%f WHERE PID='%@' ",tvalue,toid];
    
    NSString *updatePackageSql2 = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE-%f WHERE PID='%@' ",tvalue,fromid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,updatePackageSql1,updatePackageSql2, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}

@end
