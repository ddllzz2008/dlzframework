//
//  ViewController.m
//  HomeAPP
//
//  Created by 李方超 on 15/11/18.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 80)];
//    [UILabelStyle StyleForHeader:self.testLabel];
    
    self.testLabel.text=@"hello world";
    
    [self.view addSubview:self.testLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
