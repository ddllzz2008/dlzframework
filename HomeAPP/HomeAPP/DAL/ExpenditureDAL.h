//
//  ExpenditureDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/21.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FmdbHelper.h"
#import "SpendDetail.h"
#import "BusExpenditure.h"

@interface ExpenditureDAL : NSObject

+(ExpenditureDAL*)Instance;

/*
 *---------------------------插入消费---------------------------------------------*
 */
-(BOOL)addExpenditure:(NSString *)eid evalue:(double)evalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark;
/*
 *---------------------------修改消费---------------------------------------------*
 */
-(BOOL)updateExpenditure:(NSString *)eid evalue:(double)evalue oldvalue:(double)oldvalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark;
/*
 *---------------------------获取支出详细信息---------------------------------------------*
 */
-(NSMutableArray*)getExpenditureDetail:(NSString*)cid sort:(NSInteger)sort start:(NSDate*)start end:(NSDate*)end;

-(NSDictionary*)getTotal:(NSString*)cid start:(NSDate*)start end:(NSDate*)end;
/*
 *-----------获取支出详细-------------*
 */
-(BusExpenditure*)getExpendDetail:(NSString*)eid;
/*
 *---------------------------删除消费---------------------------------------------*
 */
-(BOOL)deleteExpenditure:(NSString *)eid pid:(NSString*)pid evalue:(double)evalue;
/*
 *---------------------------获取消费汇总---------------------------------------------*
 */
-(NSMutableArray*)SelectExpenditure:(NSDate*)start end:(NSDate*)end;
@end
