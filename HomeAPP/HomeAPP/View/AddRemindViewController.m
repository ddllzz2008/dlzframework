//
//  AddRemindViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/23.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "AddRemindViewController.h"

@interface AddRemindViewController (){
    NSArray *weekArray;
    NSArray *dayArray;
    
    //数据对象
    NSInteger type;
    NSInteger day;
    NSString *timehour;
    NSString *timeminute;
    NSString *marktext;
}

@end

@implementation AddRemindViewController

#pragma mark---属性初始化
-(NSArray*)getWeekArray{
    if (weekArray==nil) {
        weekArray = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    }
    return weekArray;
}
-(NSArray*)getDayArray{
    if (dayArray==nil) {
        dayArray = [NSArray arrayWithObjects:@"1日",@"2日",@"3日",@"4日",@"5日",@"6日",@"7日",@"8日",@"9日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日", nil];
    }
    return dayArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    type = 0;
    day = 0;
    
    timehour = @"00";
    timeminute = @"00";
}

-(void)initControls{
    //    init view control
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
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    backTap.delegate=self;
    backView.userInteractionEnabled=YES;
    [backView addGestureRecognizer:backTap];
    [headerView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).with.offset(10);
    }];
    
    titleView = [UILabel new];
    titleView.text=NSLocalizedString(@"remindviewcontroller_003", nil);
    titleView.textAlignment=NSTextAlignmentCenter;
    [titleView styleForTitle];
    [headerView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.width.equalTo(@150);
    }];
    
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTitle:NSLocalizedString(@"common_save", nil) forState:UIControlStateNormal];
    confirmBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [confirmBtn styleForHeader];
    [headerView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).with.offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(headerView);
    }];
    [confirmBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    /*----------添加时间控件----------*/
    timePicker = [[UIPickerView alloc] init];
    timePicker.delegate=self;
    timePicker.dataSource=self;
    [self.view addSubview:timePicker];
    [timePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@110);
    }];
    /*----------end----------*/
    
    /*----------添加类型----------*/
    typeCombox = [[DLZCombox alloc] initWithFrame:CGRectMake(0, 184+6, ScreenSize.width, 40)];
    typeCombox.backgroundColor=UIColorFromRGB(color_blue_01);
    typeCombox.layer.cornerRadius = 4;
    typeCombox.clipsToBounds=YES;
    typeCombox.textColor=UIColorFromRGB(color_white_01);
    typeCombox.font=[UIFont fontWithName:@"Arial" size:16];
    typeCombox.source=[NSArray arrayWithObjects:@"每天",@"每周",@"每月", nil];
    typeCombox.delegate=self;
    [self.view addSubview:typeCombox];
    [self.view bringSubviewToFront:typeCombox];
    
    typeDayCombox = [[DLZCombox alloc] initWithFrame:CGRectMake(0, 184+6, 0, 0)];
    typeDayCombox.backgroundColor=UIColorFromRGB(color_blue_01);
    typeDayCombox.layer.cornerRadius = 4;
    typeDayCombox.clipsToBounds=YES;
    typeDayCombox.textColor=UIColorFromRGB(color_white_01);
    typeDayCombox.font=[UIFont fontWithName:@"Arial" size:16];
    typeDayCombox.delegate=self;
    [self.view addSubview:typeDayCombox];
    [self.view bringSubviewToFront:typeDayCombox];
    /*----------end----------*/
    
    /*----------添加备注----------*/
    UIView *markView = [UIView new];
    [markView setBackgroundColor:UIColorFromRGB(color_blue_01)];
    [self.view addSubview:markView];
    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    UILabel *markTitle = [UILabel new];
    markTitle.textAlignment=NSTextAlignmentLeft;
    [markTitle setText:NSLocalizedString(@"remindviewcontroller_002", nil)];
    [markTitle styleForNormal];
    CGSize dateSize = [markTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    [markView addSubview:markTitle];
    [markTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(markView);
        make.left.equalTo(markView).with.offset(10);
        make.size.mas_equalTo(dateSize);
    }];
    markText = [UITextField new];
    [markText setBackgroundColor:UIColorFromRGB(color_white_01)];
    markText.textAlignment=NSTextAlignmentRight;
    markText.keyboardType=UIKeyboardTypeDefault;
    markText.returnKeyType=UIReturnKeyDone;
//    [markText setPlaceholder:NSLocalizedString(@"addviewcontroller_011", nil)];
    [markView addSubview:markText];
    [markText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(markTitle.mas_right).with.offset(5);
        make.right.equalTo(markView.mas_right).with.offset(-5);
        make.centerY.equalTo(markView);
        make.height.equalTo(@30);
    }];
    /*--------end--------*/
    /*--------添加要取消的输入框集合--------*/
    [self addTextFieldArray:markText];
    /*--------end--------*/
    ((AppDelegate *)[self getAppdelegate]).keyboardDelegate=self;
}

#pragma mark---事件控件
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return 24;
    }else{
        return 60;
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        NSString *hour = [[NSString stringWithFormat:@"%d",row] padLeftWithChar:2 charstring:@"0"];
        return [hour stringByAppendingString:@"时"];
    }else{
        NSString *hour = [[NSString stringWithFormat:@"%d",row] padLeftWithChar:2 charstring:@"0"];
        return [hour stringByAppendingString:@"分"];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        timehour = [[NSString stringWithFormat:@"%d",row] padLeftWithChar:2 charstring:@"0"];
    }else if (component==1){
        timeminute = [[NSString stringWithFormat:@"%d",row] padLeftWithChar:2 charstring:@"0"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---下拉选择框协议
-(void)DLZCombox:(UIView *)combox didSelectedItemAtIndex:(NSInteger)index{
    if (combox==typeCombox) {
        if (index==0) {
            CGRect frame = typeCombox.frame;
            typeCombox.frame=CGRectMake(0, frame.origin.y, ScreenSize.width, frame.size.height);
            typeDayCombox.frame=CGRectMake(0, 0, 0, 0);
            //数据保存
            type = 0;
            day = 0;
        }else if (index==1){
            CGRect frame = typeCombox.frame;
            typeCombox.frame=CGRectMake(0, frame.origin.y, ScreenSize.width/2-2.5, 40);
            typeDayCombox.frame=CGRectMake(ScreenSize.width/2+2.5, frame.origin.y, ScreenSize.width/2-2.5, 40);
            typeDayCombox.source = [self getWeekArray];
            //数据保存
            type = 1;
            day = 0;
        }else if (index==2){
            CGRect frame = typeCombox.frame;
            typeCombox.frame=CGRectMake(0, frame.origin.y, ScreenSize.width/2-2.5, 40);
            typeDayCombox.frame=CGRectMake(ScreenSize.width/2+2.5, frame.origin.y, ScreenSize.width/2-2.5, 40);
            typeDayCombox.source = [self getDayArray];
            //数据保存
            type = 2;
            day = 0;
        }
    }else if (combox==typeDayCombox){
        day = index + 1;
    }
}

#pragma mark---业务操作
-(void)saveAction:(UIButton*)sender{
    self.hub = [[AlertController sharedInstance] showMessage:self.view message:NSLocalizedString(@"common_saving", nil)];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *time = [NSString stringWithFormat:@"%@:%@",timehour,timeminute];
        NSString *state = [[RemindDAL Instance] addRemind:type time:time day:day mark:markText.text];
        if (![state isBlankString]) {
            /*开启本地通知*/
            [LocalNotificationHelper startLocalNotification:type weekday:day hour:timehour minute:timeminute body:markText.text action:@"查看"];
            /*---结束--*/
            [[AlertController sharedInstance] closeMessage:self.hub];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            self.hub.labelText = NSLocalizedString(@"common_savefailed", nil);
            [[AlertController sharedInstance] closeMessageDealy:self.hub];
        }
    });
}

-(void)keyboardStateChanged:(BOOL)ishow view:(UIView *)view rect:(CGRect)rect{
    if (view!=nil) {
        if (ishow) {
            UIView *superView = [view superview];
            CGPoint originSuper = [self.view convertPoint:CGPointZero fromView:superView];
            if (rect.size.height + originSuper.y + superView.bounds.size.height > ScreenSize.height) {
                self.view.frame=CGRectMake(0,0 - rect.size.height, self.view.frame.size.width, self.view.frame.size.height);
            }
        }else{
            if (view==markText) {
                self.view.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
            }
        }
    }
}

/*
 *-----------------返回------------------*
 */
-(void)backAction:(UITapGestureRecognizer*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
