//
//  HttpServiceView.h
//  HomeAPP
//
//  Created by 李方超 on 15/12/21.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTLJSONAdapter.h"
#import "TestModel.h"

@interface HttpServiceView : UIView

- (IBAction)downloadClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *downloadResult;

@end
