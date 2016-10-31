//
//  RemindDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/24.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "RemindDAL.h"

@implementation RemindDAL

static RemindDAL *instance = nil;

+(RemindDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
/*
 *-------------获取所有提醒------------------*
 */
-(NSMutableArray*)getAllReminds{
    NSString *sql = @" SELECT RID,REMARK,RTYPE,RTIME,STATUS,RDAY FROM BUS_REMIND";
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *resultArray = [MTLJSONAdapter modelsOfClass:[RemindModel class] fromJSONArray:array error:nil];
    return [resultArray mutableCopy];
}
/*
 *-------------获取某一个提醒------------------*
 */
-(RemindModel*)getRemind:(NSString*)rid{
    NSString *sql = [NSString stringWithFormat:@" SELECT RID,REMARK,RTYPE,RTIME,STATUS,RDAY FROM BUS_REMIND WHERE RID='%@'",rid];
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    if (array!=nil && array.count>0) {
        NSDictionary *dic = [array objectAtIndex:0];
        RemindModel *model = [MTLJSONAdapter modelOfClass:[RemindModel class] fromJSONDictionary:dic error:nil];
        return model;
    }else{
        return nil;
    }
}
/*
 *-------------添加提醒------------------*
 */
-(NSString*)addRemind:(NSInteger)type time:(NSString*)time day:(NSInteger)day mark:(NSString*)mark{
    NSString *rid = [CommonFunc NewGUID];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BUS_REMIND(RID,REMARK,RTYPE,RTIME,STATUS,RDAY) VALUES('%@','%@',%d,'%@',%d,%d)",rid,mark,type,time,1,day];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    if (state) {
        return rid;
    }else{
        return @"";
    }
}
/*
 *-------------更新提醒------------------*
 */
-(BOOL)updateRemind:(NSString*)rid type:(NSInteger)type time:(NSString*)time day:(NSInteger)day mark:(NSString*)mark{
    NSString *sql = [NSString stringWithFormat:@"UPDATE BUS_REMIND SET REMARK='%@',RTYPE=%d,RTIME='%@',RDAY=%d WHERE RID='%@' ",mark,type,time,day,rid];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    
    return state;
}
/*
 *-------------打开或关闭提醒------------------*
 */
-(BOOL)updateRemindStatus:(NSString*)rid status:(NSInteger)status{
    NSString *sql = [NSString stringWithFormat:@"UPDATE BUS_REMIND SET STATUS=%d WHERE RID='%@'",status,rid];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    
    return state;
}
/*
 *-------------删除提醒------------------*
 */
-(BOOL)deleteRemind:(NSString*)rid{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM BUS_REMIND WHERE RID='%@'",rid];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    return state;
}

@end
