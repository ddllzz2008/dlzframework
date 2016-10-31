//
//  TransferDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferDAL : NSObject

+(TransferDAL*)Instance;

-(BOOL)addTransfer:(NSString*)fromid toid:(NSString*)toid tvalue:(double)tvalue;

@end
