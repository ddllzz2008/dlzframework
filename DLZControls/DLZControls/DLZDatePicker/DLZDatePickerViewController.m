//
//  DLZDatePickerViewController.m
//  DLZControls
//
//  Created by ddllzz on 16/4/8.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DLZDatePickerViewController.h"

@interface DLZDatePickerViewController ()

@end

@implementation DLZDatePickerViewController

@synthesize selectedIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationItem * item = [self.navigationBar.items objectAtIndex: 0];
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(selectAction:)];
    item.rightBarButtonItem=rightButton;
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction:)];
    item.leftBarButtonItem=backButton;
    
    self.navigationBar.barTintColor=UIColorFromRGB(color_blue_01);
    self.navigationBar.tintColor=UIColorFromRGB(color_white_01);
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(color_white_01)}];
    
    self.topView.frame=CGRectMake(0, 0, ScreenSize.width, 20);
    self.topView.backgroundColor=UIColorFromRGB(color_blue_01);
    
    self.segmentControl.tintColor=UIColorFromRGB(color_blue_01);
    
    self.datePickerForStart.bounds=CGRectMake(0, 0, ScreenSize.width, (ScreenSize.height-self.datePickerForStart.frame.origin.y)/2);
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [self.datePickerForStart setLocale:locale];
    self.datePickerForStart.datePickerMode=UIDatePickerModeDate;
    [self.datePickerForStart addTarget:self action:@selector(dateValueChanged1:) forControlEvents:UIControlEventValueChanged];
    
    self.datePickerForStart.tintColor=UIColorFromRGB(color_blue_01);
    
    [self.datePickerForEnd setLocale:locale];
    self.datePickerForEnd.datePickerMode=UIDatePickerModeDate;
    [self.datePickerForEnd addTarget:self action:@selector(dateValueChanged2:) forControlEvents:UIControlEventValueChanged];
    
    self.datePickerForEnd.tintColor=UIColorFromRGB(color_blue_01);
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tabBarController.tabBar setHidden:YES];
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 0);
    
    [self.segmentControl addTarget:self action:@selector(rangeSelectedChange:) forControlEvents:UIControlEventValueChanged];
    self.segmentControl.selectedSegmentIndex=self.selectedIndex;
    NSDate *today =[NSDate date];
    self.datePickerForStart.maximumDate=today;
    self.datePickerForEnd.maximumDate=today;
    if (self.startDate!=nil) {
        [self.datePickerForStart setDate:self.startDate];
    }
    if (self.endDate!=nil) {
        [self.datePickerForEnd setDate:self.endDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---event method
-(void)rangeSelectedChange:(UISegmentedControl*)seg{
    NSInteger Index = seg.selectedSegmentIndex;
    self.selectedIndex = Index;
    NSDate *today = [NSDate date];
    NSArray *range;
    switch (Index) {
        case 0:
            range = [today dateForCurrentWeek];
            [self.datePickerForStart setDate:[range objectAtIndex:0]];
            [self.datePickerForEnd setDate:[range objectAtIndex:1]];
            break;
        case 1:
            range = [today dateForLastWeek];
            [self.datePickerForStart setDate:[range objectAtIndex:0]];
            [self.datePickerForEnd setDate:[range objectAtIndex:1]];
            break;
        case 2:
            range = [today dateForCurrentMonth];
            [self.datePickerForStart setDate:[range objectAtIndex:0]];
            [self.datePickerForEnd setDate:[range objectAtIndex:1]];
            break;
        case 3:
            range = [today dateForLastMonth];
            [self.datePickerForStart setDate:[range objectAtIndex:0]];
            [self.datePickerForEnd setDate:[range objectAtIndex:1]];
            break;
        case 4:
            range = [today dateForCurrentYear];
            [self.datePickerForStart setDate:[range objectAtIndex:0]];
            [self.datePickerForEnd setDate:[range objectAtIndex:1]];
            break;
        default:
            break;
    }
}

/*
 *-------------------开始日期选择更改--------------------------------*
 */
-(void)dateValueChanged1:(UIDatePicker*)sender{
    self.selectedIndex = 5;
}
/*
 *-------------------结束日期选择更改--------------------------------*
 */
-(void)dateValueChanged2:(UIDatePicker*)sender{
    self.selectedIndex = 5;
}

/*
 *-------------------点击确定事件--------------------------------*
 */
-(void)selectAction:(id)sender{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.selectedIndex] forKey:@"selectedIndex"];
    [dic setObject:[self.datePickerForStart date] forKey:@"startDate"];
    [dic setObject:[self.datePickerForEnd date] forKey:@"endDate"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DLZDatePickerNotification" object:nil userInfo:dic];
    if (self.navigationController!=nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)backAction:(id)sender{
    if (self.navigationController!=nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
