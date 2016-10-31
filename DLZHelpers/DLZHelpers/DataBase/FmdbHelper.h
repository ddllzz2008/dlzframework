//
//  FmdbHelper.h
//  DLZHelpers
//
//  Created by 李方超 on 15/12/27.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface FmdbHelper : NSObject{
    FMDatabase* db;
}


+(FmdbHelper*)Instance;

@property (nonatomic,strong) NSString* singleData;
@property (nonatomic,strong) NSString* databasepath;

-(BOOL)open;
-(BOOL)executeSql:(NSString*)sql;
-(id)querySql:(NSString*)sql;
//使用事务批量执行脚本
-(BOOL)executeSqlWithTransaction:(NSArray*)sqlList;

@end
