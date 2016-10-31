//
//  AlertController.m
//  DLZControls
//
//  Created by 李方超 on 15/12/23.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "AlertController.h"


@implementation AlertController

+(id)sharedInstance{
    static AlertController *sharedAlert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAlert = [[self alloc] init];
    });
    return sharedAlert;
}

-(void)showMessageAutoClose:(UIView*)view message:(NSString*)message{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = message;
    hub.removeFromSuperViewOnHide=YES;
    [hub hide:YES afterDelay:2];
}

-(MBProgressHUD *)showMessage:(UIView*)view message:(NSString*)message{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = message;
    hub.removeFromSuperViewOnHide=YES;
    [hub show:YES];
    return hub;
}

-(void)closeMessage:(MBProgressHUD *)hub{
    if (hub!=nil) {
        [hub hide:YES];
    }
}

-(void)closeMessageDealy:(MBProgressHUD *)hub{
    if (hub!=nil) {
        [hub hide:YES afterDelay:2];
    }
}

@end
