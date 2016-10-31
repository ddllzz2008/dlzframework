//
//  ExpenditureDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/21.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "ExpenditureDAL.h"

@implementation ExpenditureDAL

static ExpenditureDAL *instance = nil;

+(ExpenditureDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/*
 *---------------------------插入消费---------------------------------------------*
 */
-(BOOL)addExpenditure:(NSString *)eid evalue:(double)evalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark{
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BUS_EXPENDITURE(EID,EVALUE,CID,FID,PID,CREATETIME,EYEAR,EMONTH,EDAY,IMARK) VALUES('%@',%f,'%@','%@','%@','%@','%@','%@','%@','%@') ",eid,evalue,cid,fid,pid,createtime,eyear,emonth,eday,imark];
    
    NSString *updatePackageSql = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE-%f WHERE PID='%@' ",evalue,pid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,updatePackageSql, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}
/*
 *---------------------------修改消费---------------------------------------------*
 */
-(BOOL)updateExpenditure:(NSString *)eid evalue:(double)evalue oldvalue:(double)oldvalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark{
    
    double disnumber = evalue - oldvalue;
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE BUS_EXPENDITURE SET EVALUE=%f,CID='%@',FID='%@',PID='%@',CREATETIME='%@',EYEAR='%@',EMONTH='%@',EDAY='%@',IMARK='%@' WHERE EID='%@'",evalue,cid,fid,pid,createtime,eyear,emonth,eday,imark,eid];
    
    NSString *updatePackageSql = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE-%f WHERE PID='%@' ",disnumber,pid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,updatePackageSql, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}
/*
 *---------------------------获取支出详细信息---------------------------------------------*
 */
-(NSMutableArray*)getExpenditureDetail:(NSString*)cid sort:(NSInteger)sort start:(NSDate*)start end:(NSDate*)end{
    NSString *sortField = @"A.CREATETIME";
    if (sort == 0) {
        sortField = @"A.CREATETIME";
    }else if (sort == 1){
        sortField = @"A.EVALUE";
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT A.EID,A.PID,A.EVALUE,A.CREATETIME,A.IMARK,\
                     B.PNAME,B.PCOLOR \
                     FROM BUS_EXPENDITURE A \
                     INNER JOIN BASE_PACKAGE B ON A.PID = B.PID \
                     WHERE A.CREATETIME>='%@' AND A.CREATETIME<='%@'",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    if (![cid isBlankString]) {
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@" AND A.CID='%@' ",cid]];
    }
    sql = [sql stringByAppendingString:[NSString stringWithFormat:@" ORDER BY %@ DESC ",sortField]];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[SpendDetail class] fromJSONArray:array error:nil];
    return [result mutableCopy];
}

/*
 *-----------获取消费收入汇总-------------*
 */
-(NSDictionary*)getTotal:(NSString*)cid start:(NSDate*)start end:(NSDate*)end{
    NSString *sql = [NSString stringWithFormat:@"SELECT ifnull(SUM(EVALUE),0) AS MONEY,B.CNAME AS NAME FROM\
                     BUS_EXPENDITURE A INNER JOIN BASE_CATEGORY B ON A.CID = B.CID\
                     WHERE B.ISVALID=1 AND A.CREATETIME>='%@' AND A.CREATETIME<='%@'",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    if (![cid isBlankString]) {
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@" AND A.CID='%@' ",cid]];
    }
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    if (array!=nil && array.count>0) {
        return [array objectAtIndex:0];
    }
    return nil;
}

/*
 *-----------获取支出详细-------------*
 */
-(BusExpenditure*)getExpendDetail:(NSString*)eid{
    NSString *sql = [NSString stringWithFormat:@"SELECT EID,EVALUE,CID,FID,CREATETIME,EYEAR,EMONTH,EDAY,IMARK,PID FROM BUS_EXPENDITURE WHERE EID='%@'",eid];
    NSArray *array = [[FmdbHelper Instance] querySql:sql];
    if (array!=nil && array.count>0) {
        NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[BusExpenditure class] fromJSONArray:array error:nil];
        if (modelArray!=nil && modelArray.count>0) {
            return [modelArray objectAtIndex:0];
        }
    }
    return nil;
}

/*
 *---------------------------删除消费---------------------------------------------*
 */
-(BOOL)deleteExpenditure:(NSString *)eid pid:(NSString*)pid evalue:(double)evalue{
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM BUS_EXPENDITURE WHERE EID='%@'",eid];
    
    NSString *updatePackageSql = [NSString stringWithFormat:@" UPDATE BASE_PACKAGE SET PVALUE = PVALUE+%f WHERE PID='%@' ",evalue,pid];
    
    NSArray *sqlArray = [[NSArray alloc] initWithObjects:sql,updatePackageSql, nil];
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:sqlArray];
    
    return result;
}

/*
 *---------------------------获取消费汇总---------------------------------------------*
 */
-(NSMutableArray*)SelectExpenditure:(NSDate*)start end:(NSDate*)end{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT A.SUMVALUE,B.CID,B.CNAME FROM (SELECT IFNULL(SUM(A.EVALUE),0) AS SUMVALUE,A.CID FROM BUS_EXPENDITURE A WHERE A.CREATETIME>='%@' AND A.CREATETIME<='%@' GROUP BY A.CID) A INNER JOIN BASE_CATEGORY B ON A.CID=B.CID WHERE B.ISVALID=1 ORDER BY A.SUMVALUE DESC",[start formatWithCode:dateformat_08],[end formatWithCode:dateformat_09]];
    
    NSMutableArray *result = [[FmdbHelper Instance] querySql:sql];
    
    return result;
}

@end
