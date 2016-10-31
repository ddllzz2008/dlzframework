//
//  HttpServiceAssistant.h
//  DLZHelpers
//
//  Created by 李方超 on 15/12/21.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^downloadTaskProgressHandler)(NSProgress *progress);

@interface HttpServiceAssistant : NSObject

@property (readwrite, nonatomic, copy) downloadTaskProgressHandler downloadProgressHandler;

@property (readwrite,nonatomic,copy) NSProgress *progress;

@end
