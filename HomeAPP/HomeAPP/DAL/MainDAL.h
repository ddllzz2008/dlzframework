//
//  MianDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FmdbHelper.h"
#import "MTLJSONAdapter.h"
#import "SpendCategory.h"

@interface MainDAL : NSObject

+(MainDAL*)Instance;

-(NSMutableArray*)getTotalCategory:(NSDate*)start end:(NSDate*)end;

-(NSArray*)getTotal:(NSDate*)start end:(NSDate*)end;

@end
