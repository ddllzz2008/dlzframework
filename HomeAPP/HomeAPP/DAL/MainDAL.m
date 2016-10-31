//
//  MianDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MainDAL.h"

@implementation MainDAL

static MainDAL *instance = nil;

+(MainDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
/*
 *-----------获取分类消费------------*
 */
-(NSMutableArray*)getTotalCategory:(NSDate*)start end:(NSDate*)end{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT A.CID,A.EVALUE,B.CNAME,B.CCOLOR FROM\
                     ( SELECT CID,SUM(EVALUE) AS EVALUE FROM BUS_EXPENDITURE\
                      WHERE CREATETIME >= '%@' AND CREATETIME<='%@'\
                      GROUP BY CID ) A\
                     INNER JOIN BASE_CATEGORY B ON A.CID=B.CID\
                     WHERE B.ISVALID = 1\
                     ORDER BY A.EVALUE DESC",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[SpendCategory class] fromJSONArray:array error:nil];
    return [result mutableCopy];
}
/*
 *-----------获取消费收入汇总-------------*
 */
-(NSArray*)getTotal:(NSDate*)start end:(NSDate*)end{
    NSString *sql = [NSString stringWithFormat:@"SELECT ifnull(SUM(EVALUE),0) AS MONEY FROM\
                     BUS_EXPENDITURE\
                     WHERE CREATETIME>='%@' AND CREATETIME<='%@'\
                     UNION ALL\
                     SELECT ifnull(SUM(IVALUE),0) AS MONEY FROM BUS_INCOME\
                     WHERE CREATETIME>='%@' AND CREATETIME<='%@'",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09],[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    
    return array;
}

@end
