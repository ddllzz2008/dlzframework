//
//  AppliationLogic.m
//  DLZHelpers
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "AppliationLogic.h"

@implementation AppliationLogic

NSString * const dataPath = @"userdatabase.db";

//创建数据库
+(void)createDatabase{
    @try {
        //创建主束
        NSBundle *bundle=[NSBundle mainBundle];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *databasepath = [NSString stringWithFormat:@"%@/%@",[paths objectAtIndex:0],dataPath];
        
        BOOL isfileExist = [fileManager fileExistsAtPath:databasepath];
        if(!isfileExist){
            BOOL b_create = [fileManager createFileAtPath:databasepath contents:nil attributes:nil];
            if (!b_create) {
                DDLogDebug(@"调用方法ApplicationLogic.createDatabase出错,创建数据库文件报错");
            }else{
                //读取plist文件路径
                NSString *path=[bundle pathForResource:@"initdatabasesql" ofType:@"sql"];
                BOOL b_sql_file =[fileManager fileExistsAtPath:path];
                if(b_sql_file)
                {
                    NSString* sqlContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
                    BOOL isNull = [CommonFunc isBlankString:sqlContent];
                    if(!isNull){
                        NSArray* sqlList = [sqlContent componentsSeparatedByString:@";"];
                        BOOL state = [[FmdbHelper Instance] executeSqlWithTransaction:sqlList];
                        if (state) {
                            NSString *insert_path=[bundle pathForResource:@"insertdata" ofType:@"sql"];
                            BOOL b_insert_file =[fileManager fileExistsAtPath:path];
                            if(b_insert_file){
                                NSString* insertContent = [NSString stringWithContentsOfFile:insert_path encoding:NSUTF8StringEncoding error:nil];
                                isNull = [CommonFunc isBlankString:insertContent];
                                if(!isNull){
                                    sqlList = [insertContent componentsSeparatedByString:@";"];
                                    NSString *newsql=@"";
                                    NSMutableArray *newArray=[[NSMutableArray alloc] init];
                                    for(NSString* obj in sqlList){
                                        newsql = [NSString stringWithFormat:obj,[CommonFunc NewGUID]];
                                        [newArray addObject:newsql];
                                    }
                                    state = [[FmdbHelper Instance] executeSqlWithTransaction:newArray];
                                    if (!state) {
                                        DDLogDebug(@"调用方法ApplicationLogic.insertdata出错,读取脚本文件内容出错，文件内容为空");
                                    }
                                }
                            }
                        }
                    }else
                    {
                        DDLogDebug(@"调用方法ApplicationLogic.createDatabase出错,读取脚本文件内容出错，文件内容为空");
                    }
                }
                else{
                    DDLogDebug(@"调用方法ApplicationLogic.createDatabase出错,读取脚本文件内容出错，文件不存在");
                }
            }
        }
        
    }
    @catch (NSException *exception) {
        DDLogDebug(@"调用方法ApplicationLogic.createDatabase异常，%@",exception);
    }
    @finally {
        
    }
}

@end
