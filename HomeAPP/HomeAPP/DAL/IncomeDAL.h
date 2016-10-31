//
//  IncomeDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusIncome.h"

@interface IncomeDAL : NSObject

+(IncomeDAL*)Instance;

/*
 *---------------------------插入收入---------------------------------------------*
 */
-(BOOL)addIncome:(NSString *)eid evalue:(double)evalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark;
/*
 *---------------------------修改收入---------------------------------------------*
 */
-(BOOL)updateIncome:(NSString *)eid evalue:(double)evalue oldvalue:(double)oldvalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark;
/*
 *-----------获取收入汇总-------------*
 */
-(NSDictionary*)getTotal:(NSString*)cid start:(NSDate*)start end:(NSDate*)end;
/*
 *---------------------------获取收入详细信息---------------------------------------------*
 */
-(NSMutableArray*)getIncomeDetail:(NSString*)cid sort:(NSInteger)sort start:(NSDate*)start end:(NSDate*)end;

/*
 *-----------获取支出详细-------------*
 */
-(BusIncome*)getIncomeDetail:(NSString*)iid;

/*
 *---------------------------删除收入---------------------------------------------*
 */
-(BOOL)deleteIncome:(NSString *)eid pid:(NSString*)pid evalue:(double)evalue;
/*
 *---------------------------获取消费汇总---------------------------------------------*
 */
-(NSMutableArray*)SelectIncome:(NSDate*)start end:(NSDate*)end;

@end
