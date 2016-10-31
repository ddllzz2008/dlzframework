//
//  BusIncome.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/17.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface BusIncome : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy,readwrite) NSString *IID;

@property (nonatomic,readwrite) double IVALUE;

@property (nonatomic,copy,readwrite) NSString *CID;

@property (nonatomic,copy,readwrite) NSString *FID;

@property (nonatomic,copy,readwrite) NSString *PID;

@property (nonatomic,strong,readwrite) NSString *CREATETIME;

@property (nonatomic,strong,readwrite) NSString *IYEAR;

@property (nonatomic,strong,readwrite) NSString *IMONTH;

@property (nonatomic,strong,readwrite) NSString *IDAY;

@property (nonatomic,copy,readwrite) NSString *IMARK;

@end
