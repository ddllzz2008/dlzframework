//
//  HttpService.h
//  DLZHelpers
//
//  Created by 李方超 on 15/12/14.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HttpServiceAssistant.h"

@interface HttpService : NSObject

-(void)downloadFromURL:(NSString*)url
       progressHandler:(void (^)(float progress))progressHandler
        successHandler:(void (^)(NSString *path)) successHandler
         failedHandler:(void ()) failedHandler;

//get方式请求网络,带回调代码快
-(void)downloadDataWithCallBack:(NSString *)path callCompleted:(void (^)(id data))callCompleted;

@end
