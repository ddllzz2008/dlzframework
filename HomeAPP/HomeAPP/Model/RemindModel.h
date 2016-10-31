//
//  RemindModel.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/25.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface RemindModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy,readwrite) NSString *RID;

@property (nonatomic,copy,readwrite) NSString *REMARK;

@property (nonatomic,copy,readwrite) NSString *RTIME;

@property (nonatomic,readwrite) NSInteger RTYPE;

@property (nonatomic,readwrite) NSInteger STATUS;

@property (nonatomic,readwrite) NSInteger RDAY;

@end
