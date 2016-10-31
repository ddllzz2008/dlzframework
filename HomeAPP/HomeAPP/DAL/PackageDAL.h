//
//  PackageDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/3/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FmdbHelper.h"
#import "MTLJSONAdapter.h"
#import "PackageCompare.h"

@interface PackageDAL : NSObject

+(PackageDAL*)Instance;

/*
 *-----------查询钱包-------------*
 */
-(NSMutableArray*)getPackageCompare;
/*
 *-----------添加钱包-------------*
 */
-(PackageCompare *)addPackage:(NSString *)pname pvalue:(double)pvalue pcolor:(NSString *)pcolor;

/*
 *-----------修改钱包-------------*
 */
-(BOOL)updatePackage:(NSString*)pid pname:(NSString *)pname pvalue:(double)pvalue pcolor:(NSString *)pcolor;
/*
 *-----------删除钱包-------------*
 */
-(BOOL)deletePackage:(NSString*)pid;
/*
 *-----------排序钱包-------------*
 */
-(BOOL)sortPackage:(PackageCompare*)p1 p2:(PackageCompare*)p2;
@end
