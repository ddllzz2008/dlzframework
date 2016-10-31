//
//  CategoryModel.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

typedef NS_ENUM(NSInteger, CategoryType) {
    INCOME=0,
    SPEND=1
};

@interface CategoryModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy,readwrite) NSString *CID;

@property (nonatomic,copy,readwrite) NSString *CNAME;

@property (nonatomic,copy,readwrite) NSString *CCODE;

@property (nonatomic,copy,readwrite) NSString *CPARENTCODE;

@property (nonatomic,readwrite) NSInteger CSORT;

@property (nonatomic,copy,readwrite) NSString *CREATETIME;

@property (nonatomic,readwrite) NSString *CCOLOR;

@property (nonatomic,readwrite) NSInteger CTYPE;

@property (nonatomic,readwrite) int ISVALID;

@end
