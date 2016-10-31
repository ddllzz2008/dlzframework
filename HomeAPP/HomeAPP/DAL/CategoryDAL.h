//
//  CategoryDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
#import "FmdbHelper.h"
#import "MTLJSONAdapter.h"

@interface CategoryDAL : NSObject

+(CategoryDAL*)Instance;

-(NSMutableArray *)getCategory:(NSInteger)type;

/*
 *---------------------------添加类别---------------------------------------------*
 */
-(CategoryModel *)addCategory:(NSString *)name color:(NSString *)color type:(NSInteger)type createtime:(NSString *)createtime;
/*
 *---------------------------修改类别---------------------------------------------*
 */
-(BOOL)updateCategory:(NSString*)cid name:(NSString *)name color:(NSString *)color;
/*
 *---------------------------删除类别---------------------------------------------*
 */
-(BOOL)deleteCategory:(NSString*)cid;

@end
