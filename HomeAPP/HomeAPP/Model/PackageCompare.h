//
//  PackageCompare.h
//  HomeAPP
//
//  Created by ddllzz on 16/3/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface PackageCompare : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy,readwrite) NSString *PID;

@property (nonatomic,copy,readwrite) NSString *PNAME;

@property (nonatomic,readwrite) float PVALUE;

@property (nonatomic,readwrite) long PCOMPAREVALUE;

@property (nonatomic,readwrite) int PSORT;

@property (nonatomic,copy,readwrite) NSString *PCOLOR;

@property (nonatomic,readwrite) int ISVALID;

@end
