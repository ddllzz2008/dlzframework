//
//  LoginViewController.m
//  HomeAPP
//
//  Created by ddllzz2008 on 16/2/17.
//  Copyright (c) 2016年 李方超. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
//    UIButton *gcdButton;
    MBProgressHUD *hub;
    
    UIView *totalspend;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set delegate
    self.testDelegate=self;
    
    totalspend = [UIView new];
    totalspend.clipsToBounds=YES;
    totalspend.backgroundColor = UIColorFromRGB(color_blue_01);
    [totalspend setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:totalspend];
    
    [totalspend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@120);
        make.height.equalTo(@120);
        totalspend.layer.cornerRadius = 60;
        totalspend.clipsToBounds=YES;
        make.centerX.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    
//    [self.otusername setTranslatesAutoresizingMaskIntoConstraints:NO];
//    NSLayoutConstraint *constraintUserNameCenter =[NSLayoutConstraint constraintWithItem:self.otusername attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-140];
//    [self.view addConstraint:constraintUserNameCenter];
//    
//    [self.otpassword setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.otpassword attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-140]];
//    
//    [self.otlogin setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.otlogin attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:-140]];
}

-(void)initViewStyle{
    self.otloginbg.contentMode=UIViewContentModeScaleAspectFit;
    [self.otusername styleForNormal];
    [self.otpassword styleForNormal];
}

-(void)initContraints{
    [self.otloginbg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(60);
    }];
    [self.otlabeluername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.otloginbg.mas_bottom).with.offset(40);
    }];
    [self.otusername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).with.offset(-160);
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.otlabeluername.mas_bottom).with.offset(5);
    }];
    [self.otlabelpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.otusername.mas_bottom).with.offset(25);
    }];
    [self.otpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).with.offset(-160);
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.otlabelpassword.mas_bottom).with.offset(5);
    }];
    [self.otlogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view).with.offset(-220);
        make.left.equalTo(self.view).with.offset(80);
        make.top.equalTo(self.otpassword.mas_bottom).with.offset(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
*/
/*test Event*/
- (IBAction)TestGCDClick:(id)sender {
    DDLogDebug(@"gcd test button clicked");
    
    hub =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.mode=MBProgressHUDModeText;
    hub.labelText=@"que task is start";
    hub.removeFromSuperViewOnHide=YES;
    [hub show:YES];
    
    __block int a =0;
    __block int b=0;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (int i=0; i<10; i++) {
            a++;
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (int i=0; i<15; i++) {
            b++;
        }
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        if(self.testDelegate){
            [self.testDelegate showResult:a+b];
        }
    });
}

-(void)showResult:(int)result{
    double delayTnSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayTnSeconds*NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [hub setLabelText:[NSString stringWithFormat:@"result is %d",result]];
        [hub hide:YES afterDelay:1.5];
    });
}
@end
