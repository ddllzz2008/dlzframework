//
//  LoginViewController.h
//  HomeAPP
//
//  Created by ddllzz2008 on 16/2/17.
//  Copyright (c) 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControler.h"
#import "MBProgressHUD.h"

@protocol TestProtocol <NSObject>

@optional
-(void)startTest;
@required
-(void)showResult:(int)result;

@end

@interface LoginViewController : BaseViewControler<TestProtocol>


@property (weak, nonatomic) IBOutlet UIImageView *otloginbg;

@property (weak, nonatomic) IBOutlet UILabel *otlabeluername;


@property (weak, nonatomic) IBOutlet UITextField *otusername;


@property (weak, nonatomic) IBOutlet UILabel *otlabelpassword;

@property (weak, nonatomic) IBOutlet UITextField *otpassword;

@property (weak, nonatomic) IBOutlet UIButton *otlogin;

- (IBAction)TestGCDClick:(id)sender;


@property (nonatomic,weak) id<TestProtocol> testDelegate;

@end
