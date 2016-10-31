//
//  AlertController.h
//  DLZControls
//
//  Created by 李方超 on 15/12/23.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface AlertController : NSObject

+(id)sharedInstance;

-(void)showMessageAutoClose:(UIView*)view message:(NSString*)message;

-(MBProgressHUD *)showMessage:(UIView*)view message:(NSString*)message;

-(void)closeMessage:(MBProgressHUD *)hub;

-(void)closeMessageDealy:(MBProgressHUD *)hub;

@end
