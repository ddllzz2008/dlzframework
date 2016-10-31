//
//  FamilyPerson.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/22.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface FamilyPerson : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy,readwrite) NSString *fid;

@property (nonatomic,copy,readwrite) NSString *fname;

@property (nonatomic,readwrite) NSInteger fsort;

@property (nonatomic,strong,readwrite) NSString *createtime;

@property (nonatomic,copy,readwrite) NSString *isedit;

@end
