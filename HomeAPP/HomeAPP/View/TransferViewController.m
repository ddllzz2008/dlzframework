//
//  TransferViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/18.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "TransferViewController.h"

@interface TransferViewController (){
    UIButton *selectedButton;
    //business data
    NSString *fromPackage;
    NSString *toPackage;
}

@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenTabbar];
}

-(void)initControls{
    //init view control
    headerView = [UIView new];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    UIView *headerBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenSize.width, 1)];
    headerBorder.backgroundColor=UIColorFromRGB(color_gray_02);
    [headerView addSubview:headerBorder];
    
    backView = [UIImageView new];
    [backView setImage:[UIImage imageNamed:@"back_blue-Small"]];
    [headerView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).with.offset(10);
    }];
    
    titleView = [UILabel new];
    titleView.text=NSLocalizedString(@"transferviewcontroller_001", nil);
    titleView.textAlignment=NSTextAlignmentCenter;
    [titleView styleForTitle];
    [headerView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.width.equalTo(@150);
    }];
    
    /*--------转账UI--------*/
    UILabel *labelFrom = [UILabel new];
    [labelFrom styleForNormal];
    [labelFrom setText:@"从"];
    [self.view addSubview:labelFrom];
    [labelFrom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(headerView.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    buttonFrom = [UIButton new];
    buttonFrom.tag=0;
    [buttonFrom.titleLabel styleForContent];
    [buttonFrom setTitle:@"" forState:UIControlStateNormal];
    [buttonFrom setBackgroundColor:UIColorFromRGB(color_blue_01)];
    [buttonFrom addTarget:self action:@selector(choosePackage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonFrom];
    [buttonFrom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(15);
        make.top.equalTo(labelFrom.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    UIImageView *changeImage = [UIImageView new];
    [changeImage setImage:[UIImage imageNamed:@"icon_change"]];
    UITapGestureRecognizer *changeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAccount:)];
    changeTap.delegate=self;
    changeImage.userInteractionEnabled=YES;
    [changeImage addGestureRecognizer:changeTap];
    [self.view addSubview:changeImage];
    [changeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(buttonFrom);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    
    UILabel *labelTo = [UILabel new];
    labelTo.textAlignment=NSTextAlignmentRight;
    [labelTo styleForNormal];
    [labelTo setText:@"到"];
    [self.view addSubview:labelTo];
    [labelTo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-15);
        make.top.equalTo(headerView.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    buttonTo = [UIButton new];
    buttonTo.tag=1;
    [buttonTo.titleLabel styleForContent];
    [buttonTo setTitle:@"" forState:UIControlStateNormal];
    [buttonTo setBackgroundColor:UIColorFromRGB(color_blue_01)];
    [buttonTo addTarget:self action:@selector(choosePackage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTo];
    [buttonTo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-15);
        make.top.equalTo(labelFrom.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    txtMoney = [UITextField new];
    txtMoney.placeholder=NSLocalizedString(@"packagechooseviewcontroller_002", nil);
    txtMoney.borderStyle=UITextBorderStyleRoundedRect;
    txtMoney.textAlignment=NSTextAlignmentRight;
    txtMoney.keyboardType=UIKeyboardTypeDecimalPad;
    txtMoney.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:txtMoney];
    [txtMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonFrom.mas_bottom).with.offset(15);
        make.left.equalTo(self.view).with.offset(15);
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.height.equalTo(@40);
    }];
    
    UIButton *saveButton = [UIButton new];
    saveButton.backgroundColor = UIColorFromRGB(color_red_01);
    [saveButton setTitle:NSLocalizedString(@"common_confirm", nil) forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveTransfer:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    /*--------end--------*/
    
    /*-------读取颜色列表------*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArgumentArray" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    colorList = [data objectForKey:@"ColorList"];
    /*-------end------*/
    
    /*--------添加要取消的输入框集合--------*/
    [self addTextFieldArray:txtMoney];
    /*--------end--------*/
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    backTap.delegate=self;
    backView.userInteractionEnabled=YES;
    [backView addGestureRecognizer:backTap];
}

/*
 *-----------------选择钱包------------------*
 */
-(void)choosePackage:(UIButton*)sender{
    selectedButton = sender;
    PackageChooseViewController *chooseController = [[PackageChooseViewController alloc] init];
    chooseController.argumentDelegate=self;
    [self.navigationController pushViewController:chooseController animated:YES];
}

-(void)changeAccount:(UITapGestureRecognizer*)sender{
    NSString *changePID = fromPackage;
    fromPackage = toPackage;
    toPackage=changePID;
    NSString *content = buttonFrom.titleLabel.text;
    [buttonFrom setTitle:buttonTo.titleLabel.text forState:UIControlStateNormal];
    [buttonTo setTitle:content forState:UIControlStateNormal];
    UIColor *color = [buttonFrom.backgroundColor copy];
    buttonFrom.backgroundColor = buttonTo.backgroundColor;
    buttonTo.backgroundColor = color;
}

-(void)saveTransfer:(UIButton*)sender{
    BOOL result = [[TransferDAL Instance] addTransfer:fromPackage toid:toPackage tvalue:[txtMoney.text doubleValue]];
    if (result) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savefailed", nil)];
    }
}

#pragma mark---接受添加类别页面回调的协议
-(void)receiveDataFromViewController:(UIViewController *)controller argument:(id)argument{
    PackageCompare *package = argument;
    if (package!=nil && selectedButton!=nil) {
        if (selectedButton.tag==0) {
            fromPackage = package.PID;
        }else{
            toPackage = package.PID;
        }
        [selectedButton setTitle:package.PNAME forState:UIControlStateNormal];
        NSString *colorString = [colorList objectForKey:package.PCOLOR];
        unsigned long color = strtoul([colorString UTF8String],0,16);
        [selectedButton setBackgroundColor:UIColorFromRGB(color)];
    }
}

/*
 *-----------------返回------------------*
 */
-(void)backAction:(UITapGestureRecognizer*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
