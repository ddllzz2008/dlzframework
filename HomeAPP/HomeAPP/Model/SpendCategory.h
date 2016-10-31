//
//  SpendCategory.h
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface SpendCategory : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *CID;

@property (nonatomic,strong) NSString *SNAME;

@property (nonatomic,readwrite) float SVALUE;

@property (nonatomic,readwrite) NSString *COLOR;

@end
