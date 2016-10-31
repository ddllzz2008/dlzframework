//
//  CategoryDAL.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "CategoryDAL.h"

@implementation CategoryDAL

static CategoryDAL *instance = nil;

+(CategoryDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/*
 *---------------------------获取类别---------------------------------------------*
 */
-(NSMutableArray *)getCategory:(NSInteger)type{
    NSString *sql = [NSString stringWithFormat:@"SELECT CID,CNAME,CCODE,CPARENTCODE,CSORT,CCOLOR,CREATETIME,CTYPE FROM BASE_CATEGORY WHERE CTYPE=%ld AND ISVALID=1",type];
    NSMutableArray *array = [[FmdbHelper Instance]querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[CategoryModel class] fromJSONArray:array error:nil];
    return [result mutableCopy];
}

/*
 *---------------------------添加类别---------------------------------------------*
 */
-(CategoryModel *)addCategory:(NSString *)name color:(NSString *)color type:(NSInteger)type createtime:(NSString *)createtime{
    int order = 0;
    NSString *sqlMax = @"SELECT MAX(CSORT) AS CSORT FROM BASE_CATEGORY";
    NSMutableArray *maxArray = [[FmdbHelper Instance] querySql:sqlMax];
    if (maxArray!=nil && maxArray.count>0) {
        id maxValue = [[maxArray objectAtIndex:0] objectForKey:@"CSORT"];
        if ([maxValue isEqual:[NSNull null]]) {
            order = 0;
        }else{
            order = [maxValue intValue];
        }
    }
    order = order + 1;
    
    NSString *code = @"";
    sqlMax = @"SELECT MAX(CCODE) AS CCODE FROM BASE_CATEGORY";
    maxArray = [[FmdbHelper Instance] querySql:sqlMax];
    if (maxArray!=nil && maxArray.count>0) {
        NSInteger max = 1;
        id maxValue = [[maxArray objectAtIndex:0] objectForKey:@"CCODE"];
        if ([maxValue isEqual:[NSNull null]]) {
            max = 0;
        }else{
            max = [maxValue intValue];
        }
        max = max + 1;
        code = [[NSString stringWithFormat:@"%ld",(long)max] padLeftWithChar:3 charstring:@"0"];
    }
    
    NSString *guid = [CommonFunc NewGUID];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO BASE_CATEGORY(CID,CNAME,CCODE,CPARENTCODE,CSORT,CREATETIME,CCOLOR,CTYPE,ISVALID) VALUES('%@','%@','%@','%@',%d,'%@','%@',%ld,'%d')",guid,name,code,@"",order,createtime,color,type,1];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    if (state) {
        CategoryModel *model = [CategoryModel new];
        model.CID = guid;
        model.CNAME = name;
        model.CCODE = code;
        model.CPARENTCODE = @"";
        model.CSORT = order;
        model.CREATETIME = createtime;
        model.CCOLOR = color;
        model.CTYPE = type;
        model.ISVALID = 1;
        return model;
    }else{
        return nil;
    }
}

/*
 *---------------------------修改类别---------------------------------------------*
 */
-(BOOL)updateCategory:(NSString*)cid name:(NSString *)name color:(NSString *)color{
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE BASE_CATEGORY SET CNAME='%@',CCOLOR='%@' WHERE CID='%@'",name,color,cid];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    return state;
}
/*
 *---------------------------删除类别---------------------------------------------*
 */
-(BOOL)deleteCategory:(NSString*)cid{
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE BASE_CATEGORY SET ISVALID=0 WHERE CID='%@'",cid];
    BOOL state = [[FmdbHelper Instance] executeSql:sql];
    return state;
}
@end
