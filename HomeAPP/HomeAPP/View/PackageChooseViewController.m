//
//  PackageChooseViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "PackageChooseViewController.h"

@interface PackageChooseViewController ()

@end

@implementation PackageChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    titleView.text=NSLocalizedString(@"packagechooseviewcontroller_001", nil);
    titleView.textAlignment=NSTextAlignmentCenter;
    [titleView styleForTitle];
    [headerView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.width.equalTo(@150);
    }];
    
    tabelList = [UITableView new];
    tabelList.delegate=self;
    tabelList.dataSource=self;
    tabelList.allowsSelection=YES;
    
    [tabelList setBackgroundColor:[UIColor clearColor]];
    tabelList.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tabelList setTableFooterView:v];
    [self.view addSubview:tabelList];
    [tabelList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.width.equalTo(self.view);
    }];
    
    /*-------读取颜色列表------*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArgumentArray" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    colorList = [data objectForKey:@"ColorList"];
    /*-------end------*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenTabbar];
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    backTap.delegate=self;
    backView.userInteractionEnabled=YES;
    [backView addGestureRecognizer:backTap];
    tabelViewSource = [self loadData];
//    [tabelList reloadData];
}

#pragma mark---load data
-(NSMutableArray*)loadData{
    NSMutableArray *array = [[PackageDAL Instance] getPackageCompare];
    return array;
}

#pragma mark---UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tabelViewSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PackageTableViewCell *cell = [PackageTableViewCell cellWithTableView:tableView indexpath:indexPath];
    PackageCompare *package = [tabelViewSource objectAtIndex:indexPath.item];
    NSString *colorString = [colorList objectForKey:package.PCOLOR];
    unsigned long color = strtoul([colorString UTF8String],0,16);
    [cell setPointColor:color];
    [cell setTitle:package.PNAME];
    [cell setRightValue:[NSString stringWithFormat:@"%.1f",package.PVALUE]];
    [cell allowScroll:NO];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.argumentDelegate !=nil) {
        PackageCompare *package = [tabelViewSource objectAtIndex:indexPath.item];
        [self.argumentDelegate receiveDataFromViewController:nil argument:package];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
 *-----------------返回------------------*
 */
-(void)backAction:(UITapGestureRecognizer*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
