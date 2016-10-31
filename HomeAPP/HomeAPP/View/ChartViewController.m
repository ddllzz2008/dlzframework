//
//  ChartViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "ChartViewController.h"

@interface ChartViewController (){
    
    //UI Control
    UIPageControl *pageCtrl;
    
    UIScrollView *scrollView;
    UIWebView *chart1;
    UIWebView *chart2;
    DLZDatePicker *datePickerView;
    
    NSMutableArray *chartArray1;
    NSMutableArray *chartArray2;
    
    UIButton *detailButton;
}

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initControls{
    //init view control
    
    datePickerView = [DLZDatePicker new];
    datePickerView.currentViewController =self.navigationController;
    datePickerView.backgroundColor=UIColorFromRGB(color_blue_01);
    datePickerView.selectedRange=DLZDatePickerRangeCurrentMonth;
    datePickerView.delegate=self;
    [self.view addSubview:datePickerView];
    [datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 40));
    }];
    
    //滚动翻页
    int chartNumber = 2;
    scrollView = [UIScrollView new];
    scrollView.backgroundColor=[UIColor clearColor];
    scrollView.contentSize=CGSizeMake(ScreenSize.width*chartNumber, 0);
    scrollView.pagingEnabled=YES;
    scrollView.bounces=NO;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator=YES;
    scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenSize.width);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-49);
        make.left.equalTo(self.view);
        make.top.equalTo(datePickerView.mas_bottom).with.offset(0);
    }];
    
    //加载控件
    chart1 = [UIWebView new];
    chart1.backgroundColor=[UIColor clearColor];
    [chart1 setOpaque:NO];
    chart1.delegate=self;
    chart1.tag=0;
    
    [scrollView addSubview:chart1];
    [chart1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView.mas_left).with.offset(0);
        make.top.equalTo(scrollView.mas_top).with.offset(0);
        make.height.equalTo(scrollView);
        make.width.mas_equalTo(ScreenSize.width);
    }];
    
    chart2 = [UIWebView new];
    chart2.backgroundColor=[UIColor clearColor];
    [chart2 setOpaque:NO];
    chart2.delegate=self;
    chart2.tag=1;
    
    [scrollView addSubview:chart2];
    [chart2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chart1.mas_right).with.offset(0);
        make.top.equalTo(scrollView.mas_top).with.offset(0);
        make.height.equalTo(scrollView);
        make.width.mas_equalTo(ScreenSize.width);
    }];
    
    pageCtrl = [UIPageControl new];
    pageCtrl.numberOfPages=chartNumber;
    pageCtrl.currentPage=0;
    [pageCtrl addTarget:self action:@selector(chartChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageCtrl];
    [pageCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-49);
        make.width.mas_equalTo(ScreenSize.width);
        make.height.equalTo(@30);
    }];
    
    detailButton =[UIButton new];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"chartviewcontroller_003", nil)];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [detailButton setAttributedTitle:str forState:UIControlStateNormal];
//    [detailButton setTitle:NSLocalizedString(@"chartviewcontroller_003", nil) forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(viewDetail:) forControlEvents:UIControlEventTouchUpInside];
    [detailButton styleForNormal];
    [self.view addSubview:detailButton];
    [detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(datePickerView.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [self.view bringSubviewToFront:detailButton];
}

/*
 *--------------加载数据----------------*
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
    
    self.hub = [[AlertController sharedInstance] showMessage:self.view message:NSLocalizedString(@"chartviewcontroller_001", nil)];
    
    NSString *chart1Path = [[NSBundle mainBundle] pathForResource:@"PieChart" ofType:@"html"];
    NSString *chart1String = [NSString stringWithContentsOfFile:chart1Path encoding:NSUTF8StringEncoding error:nil];
    [chart1 loadHTMLString:chart1String baseURL:[NSURL URLWithString:chart1Path]];
    [chart2 loadHTMLString:chart1String baseURL:[NSURL URLWithString:chart1Path]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    if (webView==chart1) {
        chartArray1 = [[ExpenditureDAL Instance] SelectExpenditure:datePickerView.startDate end:datePickerView.endDate];
        if (chartArray1!=nil) {
            NSString *dataString = [NSString stringWithFormat:@"[{name:'%@',data:[",NSLocalizedString(@"chartviewcontroller_002", nil)];
            for (NSDictionary *dic in chartArray1) {
                dataString = [dataString stringByAppendingString:[NSString stringWithFormat:@"['%@',%f],",[dic objectForKey:@"CNAME"],[[dic objectForKey:@"SUMVALUE"] floatValue]]];
            }
            if (chartArray1.count>0) {
                dataString = [dataString substringWithRange:NSMakeRange(0, [dataString length] - 1)];
            }
            dataString = [dataString stringByAppendingString:@"]}]"];
            
            [chart1 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setPitData('%@',\"%@\")",@"支出比例图",dataString]];
        }
//    }else if (webView==chart2){
        chartArray2 = [[IncomeDAL Instance] SelectIncome:datePickerView.startDate end:datePickerView.endDate];
        if (chartArray2!=nil) {
            NSString *dataString = [NSString stringWithFormat:@"[{name:'%@',data:[",NSLocalizedString(@"chartviewcontroller_002", nil)];
            for (NSDictionary *dic in chartArray2) {
                dataString = [dataString stringByAppendingString:[NSString stringWithFormat:@"['%@',%f],",[dic objectForKey:@"CNAME"],[[dic objectForKey:@"SUMVALUE"] floatValue]]];
            }
            if (chartArray2.count>0) {
                dataString = [dataString substringWithRange:NSMakeRange(0, [dataString length] - 1)];
            }
            dataString = [dataString stringByAppendingString:@"]}]"];
            
            [chart2 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"setPitData('%@',\"%@\")",@"收入比例图",dataString]];
        }
//    }
    
    [[AlertController sharedInstance] closeMessage:self.hub];
}

/*
 *--------------手指滚动事件----------------*
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)sender{
    CGPoint offset = sender.contentOffset;
    CGRect bounds=sender.frame;
    [pageCtrl setCurrentPage:offset.x/bounds.size.width];
    
}

/*
 *--------------图表翻页控件滑动----------------*
 */
-(void)chartChanged:(UIPageControl*)sender{
    CGSize viewSize = scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage*viewSize.width, 0, viewSize.width, viewSize.height);
    [scrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark----datePicker Callback Event
-(void)DLZDatePicker:(NSDate *)startDate endDate:(NSDate *)endDate{
    DDLogDebug(@"date range is from %@ to %@",startDate,endDate);
    datePickerView.startDate = startDate;
    datePickerView.endDate = endDate;
    NSString *chart1Path = [[NSBundle mainBundle] pathForResource:@"PieChart" ofType:@"html"];
    NSString *chart1String = [NSString stringWithContentsOfFile:chart1Path encoding:NSUTF8StringEncoding error:nil];
    [chart1 loadHTMLString:chart1String baseURL:[NSURL URLWithString:chart1Path]];
    [chart2 loadHTMLString:chart1String baseURL:[NSURL URLWithString:chart1Path]];
}

-(void)viewDetail:(UIButton*)sender{
    if (pageCtrl.currentPage==0) {
        DetailViewController *detailController = [[DetailViewController alloc] initWithProperty:DetailTypeSpend cid:@"" start:datePickerView.startDate end:datePickerView.endDate];
        [self.navigationController pushViewController:detailController animated:YES];
    }
    else{
        DetailViewController *detailController = [[DetailViewController alloc] initWithProperty:DetailTypeIncome cid:@"" start:datePickerView.startDate end:datePickerView.endDate];
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

@end
