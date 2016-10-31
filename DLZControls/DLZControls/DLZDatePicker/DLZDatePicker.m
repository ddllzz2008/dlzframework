//
//  DLZDatePicker.m
//  DLZControls
//
//  Created by ddllzz on 16/4/3.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DLZDatePicker.h"

@interface DLZDatePicker(){
    
    UILabel *leftLabel;
    UILabel *rightLabel;
    UILabel *centerLabel;
}

@end

@implementation DLZDatePicker

#pragma mark---setter,getter method
@synthesize textColor;
@synthesize font;

-(id)init{
    if (self==[super init]) {
        self.selectedRange=DLZDatePickerRangeCurrentMonth;
        self.font = [UIFont fontWithName:@"Arial" size:16];
        self.textColor=UIColorFromRGB(color_black_01);
    }
    return self;
}

-(id)initWithViewController:(UIViewController*)controller{
    self = [self init];
//    currentViewController = controller;
    return self;
}

-(void)drawRect:(CGRect)rect{
    NSDate* today = [NSDate date];
    
    centerLabel = [[UILabel alloc] init];
    centerLabel.textAlignment=NSTextAlignmentCenter;
    centerLabel.font=self.font;
    centerLabel.textColor=self.textColor;
    
    leftLabel = [[UILabel alloc] init];
    leftLabel.textAlignment=NSTextAlignmentCenter;
    leftLabel.font=self.font;
    leftLabel.textColor=self.textColor;
    
    rightLabel = [[UILabel alloc] init];
    rightLabel.textAlignment=NSTextAlignmentCenter;
    rightLabel.font=self.font;
    rightLabel.textColor=self.textColor;
    
    NSArray *dateRange;
    switch (self.selectedRange) {
        case DLZDatePickerRangeCurrentMonth:
        {
            dateRange = [today dateForCurrentMonth];
            if (dateRange!=nil && dateRange.count>0) {
                self.startDate = [dateRange objectAtIndex:0];
                self.endDate = [dateRange objectAtIndex:1];
            }
        }
            break;
        case DLZDatePickerRangeCurrentYear:
        {
            dateRange = [today dateForCurrentYear];
            if (dateRange!=nil && dateRange.count>0) {
                self.startDate = [dateRange objectAtIndex:0];
                self.endDate = [dateRange objectAtIndex:1];
            }
        }
            break;
        case DLZDatePickerRangeLastMonth:
        {
            dateRange = [today dateForLastMonth];
            if (dateRange!=nil && dateRange.count>0) {
                self.startDate = [dateRange objectAtIndex:0];
                self.endDate = [dateRange objectAtIndex:1];
            }
        }
            break;
        case DLZDatePickerRangeCurrentWeek:
        {
            dateRange = [today dateForCurrentWeek];
            if (dateRange!=nil && dateRange.count>0) {
                self.startDate = [dateRange objectAtIndex:0];
                self.endDate = [dateRange objectAtIndex:1];
            }
        }
            break;
        case DLZDatePickerRangeLastWeek:
        {
            dateRange = [today dateForLastWeek];
            if (dateRange!=nil && dateRange.count>0) {
                self.startDate = [dateRange objectAtIndex:0];
                self.endDate = [dateRange objectAtIndex:1];
            }
        }
            break;
        case DLZDatePickerRangeCustomer:
        {
            self.startDate = today;
            self.endDate = today;
        }
            break;
        default:
            break;
    }
    
    [self drawLabelContent:today start:nil end:nil];
    
    [self addSubview:centerLabel];
    [self addSubview:leftLabel];
    [self addSubview:rightLabel];

    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap:)];
    leftTap.delegate=self;
    leftTap.numberOfTapsRequired=1;
    leftLabel.userInteractionEnabled=YES;
    [leftLabel addGestureRecognizer:leftTap];
    
    UITapGestureRecognizer *centerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerTap:)];
    centerTap.delegate=self;
    centerTap.numberOfTapsRequired=1;
    centerLabel.userInteractionEnabled=YES;
    [centerLabel addGestureRecognizer:centerTap];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTap:)];
    rightTap.delegate=self;
    rightTap.numberOfTapsRequired=1;
    rightLabel.userInteractionEnabled=YES;
    [rightLabel addGestureRecognizer:rightTap];
    
    /*----------添加回调通知------------*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveData:) name:@"DLZDatePickerNotification" object:nil];
}

-(void)drawLabelContent:(NSDate *)date start:(NSDate *)start end:(NSDate *)end{
    CGSize size = self.frame.size;
    CGSize centersize;
    CGSize leftsize;
    switch (self.selectedRange) {
        case DLZDatePickerRangeCurrentMonth:
            centerLabel.textAlignment=NSTextAlignmentCenter;
            centerLabel.text=[date formatWithCode:dateformat_01];
            centersize = [centerLabel getLabelSize:size];
            centerLabel.frame=CGRectMake(0, 0, centersize.width, centersize.height);
            [centerLabel setCenter:CGPointMake(size.width/2, size.height/2)];
            
            leftLabel.textAlignment=NSTextAlignmentCenter;
            leftLabel.text=@"<";
            leftsize = [leftLabel getLabelSize:size];
            leftLabel.frame=CGRectMake((ScreenSize.width-centersize.width)/2-leftsize.width-20, 0, leftsize.width, size.height);
            
            rightLabel.textAlignment=NSTextAlignmentCenter;
            rightLabel.text=@">";
            rightLabel.frame=CGRectMake(centerLabel.frame.origin.x+centerLabel.frame.size.width+20, 0, leftsize.width, size.height);
            break;
        case DLZDatePickerRangeCurrentYear:
            centerLabel.textAlignment=NSTextAlignmentCenter;
            centerLabel.text=[date formatWithCode:dateformat_02];
            centersize = [centerLabel getLabelSize:size];
            centerLabel.frame=CGRectMake(0, 0, centersize.width, centersize.height);
            [centerLabel setCenter:CGPointMake(size.width/2, size.height/2)];
            
            leftLabel.textAlignment=NSTextAlignmentCenter;
            leftLabel.text=@"<";
            leftsize = [leftLabel getLabelSize:size];
            leftLabel.frame=CGRectMake((ScreenSize.width-centersize.width)/2-leftsize.width-20, 0, leftsize.width, size.height);
            
            rightLabel.textAlignment=NSTextAlignmentCenter;
            rightLabel.text=@">";
            rightLabel.frame=CGRectMake(centerLabel.frame.origin.x+centerLabel.frame.size.width+20, 0, leftsize.width, size.height);
            break;
        case DLZDatePickerRangeLastMonth:
        {
            centerLabel.textAlignment=NSTextAlignmentCenter;
            NSArray *lastMonthArray = [date dateForLastMonth];
            centerLabel.text=[[lastMonthArray objectAtIndex:0] formatWithCode:dateformat_01];
            centersize = [centerLabel getLabelSize:size];
            centerLabel.frame=CGRectMake(0, 0, centersize.width, centersize.height);
            [centerLabel setCenter:CGPointMake(size.width/2, size.height/2)];
            
            leftLabel.textAlignment=NSTextAlignmentCenter;
            leftLabel.text=@"<";
            leftsize = [leftLabel getLabelSize:size];
            leftLabel.frame=CGRectMake((ScreenSize.width-centersize.width)/2-leftsize.width-20, 0, leftsize.width, size.height);
            
            rightLabel.textAlignment=NSTextAlignmentCenter;
            rightLabel.text=@">";
            rightLabel.frame=CGRectMake(centerLabel.frame.origin.x+centerLabel.frame.size.width+20, 0, leftsize.width, size.height);
        }
            break;
        case DLZDatePickerRangeCurrentWeek:
        {
            NSArray *currntWeekArray = [date dateForCurrentWeek];
            
            centerLabel.textAlignment=NSTextAlignmentCenter;
            centerLabel.text=@" - ";
            centersize = [centerLabel getLabelSize:size];
            centerLabel.frame=CGRectMake(0, 0, centersize.width, centersize.height);
            [centerLabel setCenter:CGPointMake(size.width/2, size.height/2)];
            
            
            float sizeLabel = (ScreenSize.width-centersize.width)/2;
            
            leftLabel.textAlignment=NSTextAlignmentRight;
            leftLabel.text=[[currntWeekArray objectAtIndex:0] formatWithCode:@"yyyy年MM月dd日"];
            leftLabel.frame=CGRectMake(0, 0, sizeLabel, size.height);
            
            rightLabel.textAlignment=NSTextAlignmentLeft;
            rightLabel.text=[[currntWeekArray objectAtIndex:1] formatWithCode:@"yyyy年MM月dd日"];
            rightLabel.frame=CGRectMake(sizeLabel+centerLabel.frame.size.width, 0, sizeLabel, size.height);
        }
            break;
        case DLZDatePickerRangeLastWeek:
        {
            NSArray *currntWeekArray = [date dateForLastWeek];
            
            centerLabel.textAlignment=NSTextAlignmentCenter;
            centerLabel.text=@" - ";
            centersize = [centerLabel getLabelSize:size];
            centerLabel.frame=CGRectMake(0, 0, centersize.width, centersize.height);
            [centerLabel setCenter:CGPointMake(size.width/2, size.height/2)];
            
            
            float sizeLabel = (ScreenSize.width-centersize.width)/2;
            
            leftLabel.textAlignment=NSTextAlignmentRight;
            leftLabel.text=[[currntWeekArray objectAtIndex:0] formatWithCode:@"yyyy年MM月dd日"];
            leftLabel.frame=CGRectMake(0, 0, sizeLabel, size.height);
            
            rightLabel.textAlignment=NSTextAlignmentLeft;
            rightLabel.text=[[currntWeekArray objectAtIndex:1] formatWithCode:@"yyyy年MM月dd日"];
            rightLabel.frame=CGRectMake(sizeLabel+centerLabel.frame.size.width, 0, sizeLabel, size.height);
        }
            break;
        case DLZDatePickerRangeCustomer:
        {
            centerLabel.textAlignment=NSTextAlignmentCenter;
            centerLabel.text=@" - ";
            centersize = [centerLabel getLabelSize:size];
            centerLabel.frame=CGRectMake(0, 0, centersize.width, centersize.height);
            [centerLabel setCenter:CGPointMake(size.width/2, size.height/2)];
            
            
            float sizeLabel = (ScreenSize.width-centersize.width)/2;
            leftLabel.textAlignment=NSTextAlignmentRight;
            leftLabel.text=[start formatWithCode:@"yyyy年MM月dd日"];
            leftLabel.frame=CGRectMake(0, 0, sizeLabel, size.height);
            
            rightLabel.textAlignment=NSTextAlignmentLeft;
            rightLabel.text=[end formatWithCode:@"yyyy年MM月dd日"];
            rightLabel.frame=CGRectMake(sizeLabel+centerLabel.frame.size.width, 0, sizeLabel, size.height);
        }
            break;
        default:
            break;
    }
}

#pragma mark---click event
/*
 *-------------------左边内容点击--------------------------------*
 *-------------------本月或上月点击左箭头到上个月-------------------*
 */
-(void)leftTap:(id)sender{
    NSDate *start = nil;
    NSDate *end=nil;
    NSString *centerText;
    BOOL isNavigator = NO;
    switch (self.selectedRange) {
        case DLZDatePickerRangeCurrentWeek:
        case DLZDatePickerRangeLastWeek:
        case DLZDatePickerRangeCustomer:
            isNavigator=YES;
            break;
        case DLZDatePickerRangeCurrentMonth:
        {
            NSDate *now = [centerLabel.text convertDateFromString:dateformat_01];
            NSArray *array = [now dateForLastMonth];
            start = [array objectAtIndex:0];
            end = [array objectAtIndex:1];
            centerText = [start formatWithCode:dateformat_01];
            isNavigator=NO;
        }
            break;
        case DLZDatePickerRangeCurrentYear:
        {
            NSDate *now = [centerLabel.text convertDateFromString:dateformat_02];
            NSArray *array = [now dateForLastYear];
            start = [array objectAtIndex:0];
            end = [array objectAtIndex:1];
            centerText = [start formatWithCode:dateformat_02];
            isNavigator=NO;
        }
            break;
        case DLZDatePickerRangeLastMonth:
        {
            NSDate *now = [centerLabel.text convertDateFromString:dateformat_01];
            NSArray *array = [now dateForLastMonth];
            start = [array objectAtIndex:0];
            end = [array objectAtIndex:1];
            centerText = [start formatWithCode:dateformat_01];
            isNavigator=NO;
        }
            break;
        default:
            isNavigator=NO;
            break;
    }
    if (isNavigator) {
        if (self.currentViewController!=nil) {
            DLZDatePickerViewController *popPicker =[[DLZDatePickerViewController alloc] initWithNibName:@"DLZDatePickerViewController" bundle:nil];
            popPicker.selectedIndex = self.selectedRange;
            start = [leftLabel.text convertDateFromString:dateformat_01];
            end = [rightLabel.text convertDateFromString:dateformat_02];
            popPicker.startDate = start;
            popPicker.endDate=end;
            if ([self.currentViewController isKindOfClass:[UINavigationController class]]) {
                __weak UINavigationController *controller = (UINavigationController*)self.currentViewController;
                [controller pushViewController:popPicker animated:YES];
            }else{
                [self.currentViewController presentViewController:popPicker animated:YES completion:nil];
            }
        }
    }else{
        centerLabel.text=centerText;
        if (self.delegate!=nil) {
            [self.delegate DLZDatePicker:start endDate:end];
        }
    }
}

/*
 *-------------------中间内容点击--------------------------------*
 *-------------------本月或上月点击中间内容无反应-------------------*
 */
-(void)centerTap:(id)sender{
    NSDate *start = nil;
    NSDate *end=nil;
    BOOL isNavigator = NO;
    switch (self.selectedRange) {
        case DLZDatePickerRangeCurrentWeek:
        case DLZDatePickerRangeLastWeek:
        case DLZDatePickerRangeCustomer:
            isNavigator=NO;
            break;
        case DLZDatePickerRangeCurrentMonth:
        {
            NSDate *date = [centerLabel.text convertDateFromString:dateformat_01];
            NSArray *array = [date dateForCurrentMonth];
            start = [array objectAtIndex:0];
            end = [array objectAtIndex:1];
            isNavigator=YES;
        }
            break;
        case DLZDatePickerRangeCurrentYear:
        {
            NSDate *date = [centerLabel.text convertDateFromString:dateformat_02];
            NSArray *array = [date dateForCurrentYear];
            start = [array objectAtIndex:0];
            end = [array objectAtIndex:1];
            isNavigator=YES;
        }
            break;
        case DLZDatePickerRangeLastMonth:
        {
            NSDate *date = [centerLabel.text convertDateFromString:dateformat_01];
            NSArray *array = [date dateForCurrentMonth];
            start = [array objectAtIndex:0];
            end = [array objectAtIndex:1];
            isNavigator=YES;
        }
        default:
            isNavigator=YES;
            break;
    }
    if (isNavigator) {
        if (self.currentViewController!=nil) {
            DLZDatePickerViewController *popPicker =[[DLZDatePickerViewController alloc] initWithNibName:@"DLZDatePickerViewController" bundle:nil];
            popPicker.selectedIndex = self.selectedRange;
            popPicker.startDate = start;
            popPicker.endDate=end;
            if ([self.currentViewController isKindOfClass:[UINavigationController class]]) {
                __weak UINavigationController *controller = (UINavigationController*)self.currentViewController;
                [controller pushViewController:popPicker animated:YES];
            }else{
                [self.currentViewController presentViewController:popPicker animated:YES completion:nil];
            }
        }
    }else{
        
    }
}

/*
 *-------------------右边内容点击--------------------------------*
 *-------------------本月或上月点击中间到下月-------------------*
 */
-(void)rightTap:(id)sender{
    NSDate *start = nil;
    NSDate *end=nil;
    NSString *centerText;
    NSDate *today = [NSDate date];
    BOOL isNavigator = NO;
    switch (self.selectedRange) {
        case DLZDatePickerRangeCurrentWeek:
        case DLZDatePickerRangeLastWeek:
        case DLZDatePickerRangeCustomer:
            isNavigator=YES;
            break;
        case DLZDatePickerRangeCurrentMonth:
        {
            if ([[today formatWithCode:dateformat_01] isEqualToString:centerLabel.text]) {
                return;
            }else{
                NSDate *now = [centerLabel.text convertDateFromString:dateformat_01];
                NSArray *array = [now dateForNextMonth];
                start = [array objectAtIndex:0];
                end = [array objectAtIndex:1];
                centerText = [start formatWithCode:dateformat_01];
                isNavigator=NO;
            }
        }
            break;
        case DLZDatePickerRangeCurrentYear:
        {
            if ([[today formatWithCode:dateformat_02] isEqualToString:centerLabel.text]) {
                return;
            }else{
                NSDate *now = [centerLabel.text convertDateFromString:dateformat_02];
                NSArray *array = [now dateForNextYear];
                start = [array objectAtIndex:0];
                end = [array objectAtIndex:1];
                centerText = [start formatWithCode:dateformat_02];
                isNavigator=NO;
            }
        }
            break;
        case DLZDatePickerRangeLastMonth:
        {
            if ([[today formatWithCode:dateformat_01] isEqualToString:centerLabel.text]) {
                return;
            }else{
                NSDate *now = [centerLabel.text convertDateFromString:dateformat_01];
                NSArray *array = [now dateForNextMonth];
                start = [array objectAtIndex:0];
                end = [array objectAtIndex:1];
                centerText = [start formatWithCode:dateformat_01];
                isNavigator=NO;
            }
        }
            break;
        default:
            isNavigator=NO;
            break;
    }
    if (isNavigator) {
        if (self.currentViewController!=nil) {
            DLZDatePickerViewController *popPicker =[[DLZDatePickerViewController alloc] initWithNibName:@"DLZDatePickerViewController" bundle:nil];
            popPicker.selectedIndex = self.selectedRange;
            start = [leftLabel.text convertDateFromString:dateformat_01];
            end = [rightLabel.text convertDateFromString:dateformat_02];
            popPicker.startDate = start;
            popPicker.endDate=end;
            if ([self.currentViewController isKindOfClass:[UINavigationController class]]) {
                __weak UINavigationController *controller = (UINavigationController*)self.currentViewController;
                [controller pushViewController:popPicker animated:YES];
            }else{
                [self.currentViewController presentViewController:popPicker animated:YES completion:nil];
            }
        }
    }else{
        centerLabel.text=centerText;
        if (self.delegate!=nil) {
            [self.delegate DLZDatePicker:start endDate:end];
        }
    }
}

#pragma mark---receive callback data
-(void)receiveData:(NSNotification*)notification{
    NSDictionary *postData = [notification userInfo];
    NSInteger selectedIndex = [[postData objectForKey:@"selectedIndex"] intValue];
    self.selectedRange =selectedIndex;
    NSDate *start = [postData objectForKey:@"startDate"];
    NSDate *end = [postData objectForKey:@"endDate"];
    [self drawLabelContent:[NSDate date] start:start end:end];
    
    self.startDate = start;
    self.endDate =end;
    
    if (self.delegate!=nil) {
        [self.delegate DLZDatePicker:start endDate:end];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark---show date picker
static NSDictionary *sheetActionDictionary;

+(void)setSheetActionDictionary:(NSDictionary*)dic{
    sheetActionDictionary = dic;
}
+(NSDictionary*)getSheetActionDictionary{
    return sheetActionDictionary;
}

+(void)showActionDateSheet:(UIView*)root date:(NSDate *)date chooseCallBack:(void (^)(NSArray*)) chooseCallBack{
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"DLZDateActionSheet" owner:nil options:nil];
    UIView *view = [viewArray lastObject];
    if (view!=nil) {
        
        NSArray *subViews = [view subviews];
        UIDatePicker *picker = [subViews objectAtIndex:2];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [picker setLocale:locale];
        picker.datePickerMode=UIDatePickerModeDate;
        picker.tintColor=UIColorFromRGB(color_blue_01);
        
        UIView *rootView = [[picker subviews] objectAtIndex:0];
        if (rootView!=nil) {
            [rootView setBackgroundColor:UIColorFromRGB(color_white_01)];
        }
        __strong void(^callBack)(NSArray*) = chooseCallBack;
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:view,@"view",picker,@"picker",callBack,@"chooseCallBack",nil];
        [DLZDatePicker setSheetActionDictionary:dic];
        /*------点击事件--------*/
        UIView *actionView = [subViews objectAtIndex:1];
        if (actionView!=nil) {
            NSArray *actionSubViews = [actionView subviews];
            UIButton *yBtn = [actionSubViews objectAtIndex:0];
            UIButton *tBtn = [actionSubViews objectAtIndex:1];
            UIButton *conBtn = [actionSubViews objectAtIndex:2];
            [yBtn addTarget:self action:@selector(yesterdayAction:) forControlEvents:UIControlEventTouchUpInside];
            [tBtn addTarget:self action:@selector(todayAction:) forControlEvents:UIControlEventTouchUpInside];
            [conBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [root addSubview:view];
    }
}

+(void)yesterdayAction:(id)sender{
    UIDatePicker *picker = [[DLZDatePicker getSheetActionDictionary] objectForKey:@"picker"];
    if (picker!=nil) {
        [picker setDate:[NSDate dateForDays:-1]];
    }
}

+(void)todayAction:(id)sender{
    UIDatePicker *picker = [[DLZDatePicker getSheetActionDictionary] objectForKey:@"picker"];
    if (picker!=nil) {
        [picker setDate:[NSDate date]];
    }
}

+(void)confirmAction:(id)sender{
    
    NSDictionary *dic = [DLZDatePicker getSheetActionDictionary];
    
    UIView *view = [dic objectForKey:@"view"];
    UIDatePicker *picker = [dic objectForKey:@"picker"];
    void(^chooseCallBack)(NSArray*) =[dic objectForKey:@"chooseCallBack"];
    if (view!=nil) {
        [view removeFromSuperview];
    }
    NSString *result = @"";
    NSDate *chooseDate = [picker date];
    if ([[chooseDate formatWithCode:dateformat_03] isEqualToString:[[NSDate date] formatWithCode:dateformat_03]]) {
        result=@"今天";
    }
    else if ([[chooseDate formatWithCode:dateformat_03] isEqualToString:[[NSDate dateForDays:-1] formatWithCode:dateformat_03]]){
        result = @"昨天";
    }
    else{
        result = [chooseDate formatWithCode:dateformat_03];
    }
    NSArray *resultArray = [[NSArray alloc] initWithObjects:chooseDate,result, nil];
    if (chooseCallBack!=nil && picker!=nil) {
        chooseCallBack(resultArray);
    }
    [DLZDatePicker setSheetActionDictionary:nil];
}

@end
