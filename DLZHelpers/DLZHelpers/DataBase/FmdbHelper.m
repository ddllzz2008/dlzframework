//
//  FmdbHelper.m
//  DLZHelpers
//
//  Created by 李方超 on 15/12/27.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "FmdbHelper.h"

@implementation FmdbHelper

@synthesize singleData = _singleData;
static FmdbHelper *sharedInstance = nil;
+(FmdbHelper*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedInstance = [[self alloc] init];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        sharedInstance.databasepath = [NSString stringWithFormat:@"%@/%@",[paths objectAtIndex:0],@"userdatabase.db"];
    });
    return sharedInstance;
}

-(BOOL)open{
    db=[FMDatabase databaseWithPath:self.databasepath];
    BOOL res =[db open];
    if(res==NO){
        DDLogDebug(@"调用方法BGSqliteService.open打开数据库失败");
    }else{
        
    }
    return res;
}

-(void)close{
    if(db!=nil){
        [db close];
    }
}

-(BOOL)executeSql:(NSString*)sql{
    [self open];
    BOOL res = [db executeUpdate:sql];
    if(res==NO){
        DDLogDebug(@"调用方法BGSqliteService.executeSql执行脚本%@",sql);
    }
    [db close];
    return res;
}

-(id)querySql:(NSString*)sql{
    [self open];
    FMResultSet* set =[db executeQuery:sql];
    NSMutableArray* array =[NSMutableArray arrayWithCapacity:0];
    int columnCount=0;
    while ([set next]) {
        columnCount = [set columnCount];
        NSString* columnName;
        NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithCapacity:columnCount];
        for (int i=0; i<columnCount; i++) {
            columnName =[set columnNameForIndex:i];
            [dictionary setValue:[set objectForColumnIndex:i] forKey:columnName];
        }
        [array addObject:dictionary];
    }
    [db close];
    return  array;
}

//使用事务批量执行脚本
-(BOOL)executeSqlWithTransaction:(NSArray*)sqlList{
    [self open];
    [db beginTransaction];
    BOOL hresult=NO;
    BOOL IsRollback=NO;
    @try {
        for (id sql in sqlList) {
            if ([sql isEqualToString:@""] || sql == nil) {
                continue;
            }
            hresult = [db executeUpdate:[NSString stringWithFormat:@"%@;",sql]];
            if (hresult == NO) {
                IsRollback = YES;
                break;
            }
        }
    }
    @catch (NSException *exception) {
        IsRollback=YES;
        [db rollback];
    }
    @finally {
        if(!IsRollback){
            hresult = [db commit];
        }else{
            [db rollback];
        }
    }
    [db close];
    return hresult;
}

@end
