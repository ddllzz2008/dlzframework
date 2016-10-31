//
//  HttpService.m
//  DLZHelpers
//
//  Created by 李方超 on 15/12/14.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "HttpService.h"

@implementation HttpService
/*
 从URL下载文件
*/
-(void)downloadFromURL:(NSString*)url
       progressHandler:(void (^)(float progress))progressHandler
       successHandler:(void (^)(NSString *path)) successHandler
       failedHandler:(void ()) failedHandler{
    
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableURLRequest *request = [serializer requestWithMethod:@"GET" URLString:url parameters:nil error:nil];
    
    [request setTimeoutInterval:request_download_timeout];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    path =[NSString stringWithFormat:@"%@/%@",path,@"bingocity.xml"];
    
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:path append:NO]];
    
    [operation setDownloadProgressBlock:^void(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead/totalBytesExpectedToRead;
        DDLogDebug(@"progress is %f",p);
        if (progressHandler) {
            progressHandler(p);
        }
    }];
    [operation setCompletionBlockWithSuccess:^void(AFHTTPRequestOperation * __nonnull operation, id __nonnull responseObject) {
        DDLogDebug(@"downlad from url %@ success",url);
        if (successHandler) {
            successHandler(path);
        }
        
    } failure:^void(AFHTTPRequestOperation * __nonnull operation, NSError * __nonnull error) {
        DDLogDebug(@"downlad from url %@ failed",url);
        if (failedHandler) {
            failedHandler();
        }
    }];
    [operation start];
}

//get方式请求网络,带回调代码快
-(void)downloadDataWithCallBack:(NSString *)path callCompleted:(void (^)(id data))callCompleted{
    @try {
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        
        [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DDLogDebug(@"请求时间:%@,请求地址:%@",[CommonFunc getCurrentDate],path);
            if (responseObject!=nil) {
                if(callCompleted){
                    callCompleted(responseObject);
                }
            }else{
                if(callCompleted){
                    callCompleted(nil);
                }
                DDLogDebug(@"请求错误:%@,请求地址:%@",[CommonFunc getCurrentDate],path);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(callCompleted){
                callCompleted(nil);
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
    }
    @catch (NSException *exception) {
        DDLogDebug(@"请求错误:%@,错误消息:%@",[CommonFunc getCurrentDate],exception);
        if(callCompleted){
            callCompleted(nil);
        }
    }
    @finally {
    }
}

@end
