//
//  HttpServiceView.m
//  HomeAPP
//
//  Created by 李方超 on 15/12/21.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "HttpServiceView.h"

@implementation HttpServiceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)downloadClick:(id)sender {
    HttpService *service = [[HttpService alloc] init];
    [service downloadFromURL:@"http://121.40.179.27:901/SysData/bingocity.xml" progressHandler:^(float progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.downloadResult.text = [NSString stringWithFormat:@"download progress %f",progress];
        });
    } successHandler:^(NSString *url){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.downloadResult.text = [NSString stringWithFormat:@"download to path %@",url];
        });
    }
    failedHandler:nil];
}

- (IBAction)requestForJsonClick:(id)sender {
    HttpService *service = [[HttpService alloc] init];
    [service downloadDataWithCallBack:@"http://121.40.179.27:901/api/Async/GetAsyncData?table=ALL&timestamp=" callCompleted:^(id data) {
//        [MTLJSONAdapter]
    }];
}

@end
