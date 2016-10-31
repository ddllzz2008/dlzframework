//
//  SpendDetail.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/5.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface SpendDetail : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *EID;

@property (nonatomic,strong) NSString *PID;

@property (nonatomic,readwrite) double EVALUE;

@property (nonatomic,strong) NSString *CREATETIME;

@property (nonatomic,readwrite) NSString *IMARK;

@property (nonatomic,strong,readwrite) NSString *PNAME;

@property (nonatomic,strong,readwrite) NSString *PCOLOR;

@end
