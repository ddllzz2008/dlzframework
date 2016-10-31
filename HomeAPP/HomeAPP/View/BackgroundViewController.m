//
//  BackgroundViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/8/3.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

@end

@implementation BackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenTabbar];
}

/*!
 *  @brief 初始化控件属性
 *
 *  @since 1.1
 */
-(void)initControls{
    [self.titleView setText:NSLocalizedString(@"backgroundviewcontroller_001", nil)];
    self.titleView.textAlignment=NSTextAlignmentCenter;
    [self.titleView styleForTitle];
    
    self.headerBorder.backgroundColor=UIColorFromRGB(color_gray_02);
    
    [self.btnSave setTitle:NSLocalizedString(@"common_confirm", nil) forState:UIControlStateNormal];
    self.btnSave.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [self.btnSave styleForNormal];
    [self.btnSave addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    backTap.delegate=self;
    self.backView.userInteractionEnabled=YES;
    [self.backView addGestureRecognizer:backTap];
}
/*!
 *  @brief 保存背景图片
 *
 *  @param btn 保存按钮
 */
-(void)saveAction:(UIButton*)btn{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---事件
-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
