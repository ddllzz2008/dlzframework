//
//  RemindViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/23.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "RemindViewController.h"

@interface RemindViewController (){
    
    NSMutableArray *tableSource;
    //数据字典
    
    NSArray *typeSource;
    NSArray *weekSource;
    NSArray *monthSource;
}

@end

@implementation RemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    UIImageView *backView = [UIImageView new];
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
    titleView.text=NSLocalizedString(@"remindviewcontroller_001", nil);
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
    tabelList.separatorColor = UIColorFromRGB(color_white_01);
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tabelList setTableFooterView:v];
    [self.view addSubview:tabelList];
    [tabelList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view).with.offset(-50);
        make.width.equalTo(self.view);
    }];
    
    UIButton *saveButton = [UIButton new];
    saveButton.backgroundColor = UIColorFromRGB(color_red_01);
    [saveButton setTitle:NSLocalizedString(@"remindviewcontroller_003", nil) forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(addRemind:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenTabbar];
    
    if (typeSource==nil) {
        typeSource = [NSArray arrayWithObjects:@"每天",@"每周",@"每月", nil];
    }
    if (weekSource==nil) {
        weekSource = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    }
    if (monthSource==nil) {
        monthSource = [NSArray arrayWithObjects:@"1日",@"2日",@"3日",@"4日",@"5日",@"6日",@"7日",@"8日",@"9日",@"10日",@"11日",@"12日",@"13日",@"14日",@"15日",@"16日",@"17日",@"18日",@"19日",@"20日",@"21日",@"22日",@"23日",@"24日",@"25日",@"26日",@"27日",@"28日",@"29日",@"30日",@"31日", nil];
    }
    
    tableSource = [[RemindDAL Instance] getAllReminds];
    [tabelList reloadData];
}

#pragma mark---UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindTableViewCell *cell = [RemindTableViewCell cellWithTableView:tableView indexpath:indexPath];
    if (tableSource!=nil&&tableSource.count>indexPath.item) {
        RemindModel *model = [tableSource objectAtIndex:indexPath.item];
        if (model.RTYPE==0) {
            [cell setTimeValue:[NSString stringWithFormat:@"%@ %@",[typeSource objectAtIndex:model.RTYPE],model.RTIME]];
        }else if(model.RTYPE==1){
            [cell setTimeValue:[NSString stringWithFormat:@"%@ %@ %@",[typeSource objectAtIndex:model.RTYPE],[weekSource objectAtIndex:model.RDAY],model.RTIME]];
        }else if (model.RTYPE==2){
            [cell setTimeValue:[NSString stringWithFormat:@"%@ %@ %@",[typeSource objectAtIndex:model.RTYPE],[monthSource objectAtIndex:model.RDAY],model.RTIME]];
        }
        [cell setMessageValue:model.REMARK];
    }
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        RemindModel *model = [tableSource objectAtIndex:indexPath.item];
        if (model!=nil) {
            BOOL state = [[RemindDAL Instance] deleteRemind:model.RID];
            if (state) {
                [LocalNotificationHelper deleteLocalNotification:model.RID];
                [tableSource removeObjectAtIndex:indexPath.item];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_failed", nil)];
            }
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark---跳转事件
/*
 *-----------添加提醒-------------*
 */
-(void)addRemind:(UIButton*)sender{
    AddRemindViewController *addcontroller = [[AddRemindViewController alloc] init];
    [self.navigationController pushViewController:addcontroller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *-----------------返回------------------*
 */
-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
