//
//  RemindDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/24.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemindModel.h"

@interface RemindDAL : NSObject

+(RemindDAL*)Instance;
/*
 *-------------获取所有提醒------------------*
 */
-(NSMutableArray*)getAllReminds;
/*
 *-------------获取某一个提醒------------------*
 */
-(RemindModel*)getRemind:(NSString*)rid;
/*
 *-------------添加提醒------------------*
 */
-(NSString*)addRemind:(NSInteger)type time:(NSString*)time day:(NSInteger)day mark:(NSString*)mark;
/*
 *-------------更新提醒------------------*
 */
-(BOOL)updateRemind:(NSString*)rid type:(NSInteger)type time:(NSString*)time day:(NSInteger)day mark:(NSString*)mark;
/*
 *-------------打开或关闭提醒------------------*
 */
-(BOOL)updateRemindStatus:(NSString*)rid status:(NSInteger)status;
/*
 *-------------删除提醒------------------*
 */
-(BOOL)deleteRemind:(NSString*)rid;

@end
