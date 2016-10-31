//
//  TestModel.h
//  HomeAPP
//
//  Created by 李方超 on 16/1/3.
//  Copyright (c) 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface JsonResult : MTLModel<MTLJSONSerializing>

@property (nonatomic,readwrite) int Status;
@property (nonatomic,strong) NSString *Message;
@property (nonatomic,readwrite) NSString *MessageCode;

@end

@interface JsonModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,readwrite) BOOL IsClear;
@property (nonatomic,readwrite) long TimeStamp;
@property (nonatomic,strong) NSNumber *Datas;

@end

@interface TableModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSString *TableName;
@property (nonatomic,readwrite) long timestamp;
@property (nonatomic,strong) NSArray *Data;

@end

@interface APP_CAR_MODEL : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* CID;
@property (nonatomic,retain) NSString* NID;
@property (nonatomic,retain) NSString* NAME;
@property BOOL isvalid;

@end

@interface APP_CAR_NUMBER : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* NID;
@property (nonatomic,retain) NSString* UID;
@property (nonatomic,retain) NSString* NAME;
@property BOOL isvalid;

@end

@interface APP_CAR_TYPE : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* UID;
@property (nonatomic,retain) NSString* NAME;
@property (nonatomic,retain) NSString* FCHAR;
@property BOOL isvalid;

@end

@interface APP_LABEL_COLOR : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* LCID;
@property (nonatomic,retain) NSString* NAME;
@property (nonatomic,retain) NSString* CODE;
@property BOOL isvalid;

@end

@interface APP_SYS_LABELTYPE : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* CODE;
@property (nonatomic,retain) NSString* NAME;
@property (nonatomic,retain) NSString* PARENTCODE;
@property NSInteger TYPEORDER;
@property BOOL isvalid;

@end

@interface APP_SYS_ORDERCONFIG : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* ID;
@property double TOTALMONEY;
@property NSInteger OPERATOR;
@property double VALUE;
@property (nonatomic,retain) NSDate* VALIDSTART;
@property (nonatomic,retain) NSDate* VALIDEND;
@property BOOL isvalid;

@end

@interface APP_SYS_ORDERDEDUCT : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* ID;
@property double TOTALMONEY;
@property NSInteger OPERATOR;
@property double VALUE;
@property (nonatomic,retain) NSDate* VALIDSTART;
@property (nonatomic,retain) NSDate* VALIDEND;
@property BOOL isvalid;

@end

@interface APP_SYS_USERLEVEL : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* ID;
@property (nonatomic,retain) NSString* NAME;
@property NSInteger TO;
@property double VALUE;
@property BOOL isvalid;

@end

@interface APP_SYS_USERLEVELRULE : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* ID;
@property (nonatomic,retain) NSString* FIELD;
@property NSInteger TO;
@property double VALUE;
@property BOOL isvalid;

@end

@interface APP_SYS_MEIDATYPE : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString* TID;
@property (nonatomic,retain) NSString* NAME;
@property NSInteger ORDER;
@property NSInteger TYPEORDER;
@property BOOL isvalid;

@end

@interface APP_SYS_SYSCONFIG : MTLModel<MTLJSONSerializing>

@property NSInteger id;
@property (nonatomic,retain) NSString* syskey;
@property (nonatomic,retain) NSString* sysvalue;
@property BOOL isvalid;

@end
