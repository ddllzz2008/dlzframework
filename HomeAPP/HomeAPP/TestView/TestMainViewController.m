//
//  TestMainViewController.m
//  HomeAPP
//
//  Created by 李方超 on 15/12/21.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "TestMainViewController.h"

@interface TestMainViewController ()

@end

@implementation TestMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)HttpClick:(id)sender {
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"HttpServiceView" owner:nil options:nil];
    UIView *view = [array firstObject];
    
    view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    [self.view addSubview:view];
}
@end
