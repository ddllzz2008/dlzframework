//
//  AppliationLogic.h
//  DLZHelpers
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FmdbHelper.h"

@interface AppliationLogic : NSObject

extern NSString * const dataPath;

//创建数据库
+(void)createDatabase;

@end
