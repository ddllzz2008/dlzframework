//
//  MainViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/24.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    //UI Control
    UIView *headerView;
    UIImageView *alertView;
    UIView *topView;
    
    UIView *totalspend;
    UILabel *totalTitle;
    UILabel *totalValue;
    
    UIView *totalincome;
    UILabel *totalincomeTitle;
    UILabel *totalincomeValue;
    
    UITableView *collectionList;
    
    //soure
    NSDictionary *colorList;
    NSMutableArray *collectionSource;
    
    CGRect originFrame;
    int scrollstate;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    scrollstate=0;
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
    /*-----------本月支出------------*/
    totalspend = [UIView new];
    totalspend.layer.cornerRadius = 45;
    totalspend.clipsToBounds=YES;
    totalspend.backgroundColor = UIColorFromRGB(color_blue_01);
    UITapGestureRecognizer *spendTotalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTotalSpend:)];
    spendTotalTap.numberOfTapsRequired = 1;
    spendTotalTap.delegate=self;
    [totalspend addGestureRecognizer:spendTotalTap];
    [self.view addSubview:totalspend];
    [totalspend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(self.view).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    totalTitle = [UILabel new];
    totalTitle.text=@"本月消费";
    totalTitle.textAlignment=NSTextAlignmentCenter;
    [totalTitle styleForHeader];
    [totalspend addSubview:totalTitle];

    [totalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalspend);
        make.top.equalTo(totalspend).with.offset(20);
        make.width.equalTo(@90);
    }];

    totalValue = [UILabel new];
    totalValue.text=@"200$";
    totalValue.textAlignment=NSTextAlignmentCenter;
    [totalValue styleForHeader];
    [totalspend addSubview:totalValue];
    
    [totalValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalspend);
        make.bottom.equalTo(totalspend.mas_bottom).with.offset(-20);
        make.width.equalTo(@90);
    }];
    
    /*-----------本月收入------------*/
    totalincome = [UIView new];
    totalincome.layer.cornerRadius = 45;
    totalincome.clipsToBounds=YES;
    totalincome.backgroundColor = UIColorFromRGB(color_blue_01);
    UITapGestureRecognizer *incomeTotalTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTotalIncome:)];
    incomeTotalTap.numberOfTapsRequired = 1;
    incomeTotalTap.delegate=self;
    [totalincome addGestureRecognizer:incomeTotalTap];
    [self.view addSubview:totalincome];
    [totalincome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-30);
        make.top.equalTo(self.view).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    totalincomeTitle = [UILabel new];
    totalincomeTitle.text=@"本月收入";
    totalincomeTitle.textAlignment=NSTextAlignmentCenter;
    [totalincomeTitle styleForHeader];
    [totalincome addSubview:totalincomeTitle];
    
    [totalincomeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalincome);
        make.top.equalTo(totalincome).with.offset(20);
        make.width.equalTo(@90);
    }];
    
    totalincomeValue = [UILabel new];
    totalincomeValue.text=@"200$";
    totalincomeValue.textAlignment=NSTextAlignmentCenter;
    [totalincomeValue styleForHeader];
    [totalincome addSubview:totalincomeValue];
    
    [totalincomeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalincome);
        make.bottom.equalTo(totalincome.mas_bottom).with.offset(-20);
        make.width.equalTo(@90);
    }];

    /*-----------提醒图标--------------*/
    alertView = [UIImageView new];
    [alertView setImage:[UIImage imageNamed:@"nav_clock-Small"]];
    [headerView addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(29, 29));
        make.centerY.equalTo(totalspend);
        make.centerX.equalTo(self.view);
    }];
    /*-----------end------------*/
    /*-----------中间连线------------*/
    UIView *leftline = [UIView new];
    leftline.backgroundColor = UIColorFromRGB(color_gray_01);
    [self.view addSubview:leftline];
    [leftline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(totalspend.mas_right).with.offset(0);
        make.right.equalTo(alertView.mas_left).with.offset(0);
        make.centerY.equalTo(totalspend);
    }];
    UIView *rightline = [UIView new];
    rightline.backgroundColor = UIColorFromRGB(color_gray_01);
    [self.view addSubview:rightline];
    [rightline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(alertView.mas_right).with.offset(0);
        make.right.equalTo(totalincome.mas_left).with.offset(0);
        make.centerY.equalTo(totalspend);
    }];
    /*-----------end------------*/
    
    collectionList = [UITableView new];
    collectionList.delegate=self;
    collectionList.dataSource=self;
    collectionList.allowsSelection=YES;
    [collectionList setBackgroundColor:[UIColor clearColor]];
    collectionList.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [collectionList setTableFooterView:v];
    [self.view addSubview:collectionList];
    [collectionList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(totalspend.mas_bottom).with.offset(15);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(-49);
        make.width.equalTo(self.view);
    }];
    
    /*-----------顶部连线------------*/
    topView = [UIView new];
    [topView setBackgroundColor:UIColorFromRGB(color_gray_01)];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.centerX.equalTo(alertView);
        make.top.equalTo(alertView.mas_bottom).with.offset(0);
        make.bottom.equalTo(collectionList.mas_top).with.offset(0);
    }];
    [self.view bringSubviewToFront:topView];
}

#pragma mark---load data
-(NSMutableArray*)loadData{
    
    NSMutableArray *array;
    
    NSArray *dateArray = [[NSDate date] dateForCurrentMonth];
    
    //获取汇总
    NSArray *totalArray =[[MainDAL Instance] getTotal:[dateArray objectAtIndex:0] end:[dateArray objectAtIndex:1]];
    
    if (totalArray!=nil && totalArray.count>1) {
        double spend = [[[totalArray objectAtIndex:0] objectForKey:@"MONEY"] doubleValue];
        double income =[[[totalArray objectAtIndex:1] objectForKey:@"MONEY"] doubleValue];
        [totalValue setText:[NSString stringWithFormat:@"%.1f",spend]];
        [totalincomeValue setText:[NSString stringWithFormat:@"%.1f",income]];
    }
    
    if (dateArray!=nil && dateArray.count > 1) {
        array = [[MainDAL Instance] getTotalCategory:[dateArray objectAtIndex:0] end:[dateArray objectAtIndex:1]];
    }else{
        array = [[NSMutableArray alloc] init];
    }
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
    /*-------读取颜色列表------*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArgumentArray" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    colorList = [data objectForKey:@"ColorList"];
    
    collectionSource = [self loadData];
    
    [collectionList reloadData];
}

#pragma mark---UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return collectionSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *cell = [DetailTableViewCell cellWithTableView:tableView];
    
    SpendCategory *spend = [collectionSource objectAtIndex:indexPath.item];
    
    NSString *colorString = [colorList objectForKey:spend.COLOR];
    unsigned long color = strtoul([colorString UTF8String],0,16);
    [cell setCenterColor:color];

    [cell setRightvalue:[NSString stringWithFormat:@"%.1f",spend.SVALUE]];
    [cell setLeftvalue:spend.SNAME];
//    [cell setLeftColor:UIColorFromRGB(color_gray_01)];
//    [cell setLeftMark:[[detail.CREATETIME convertDateFromString:dateformat_07] formatWithCode:dateformat_10]];
//    [cell setLeftMarkColor:UIColorFromRGB(color_gray_01)];
    //隐藏最后一行的下线
    if (indexPath.item==collectionSource.count-1) {
        [cell hiddenBottom];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpendCategory *spend = [collectionSource objectAtIndex:indexPath.item];
    if (spend!=nil) {
        NSArray *dateArray = [[NSDate date] dateForCurrentMonth];
        DetailViewController *detailController = [[DetailViewController alloc] initWithProperty:DetailTypeSpend cid:spend.CID start:[dateArray objectAtIndex:0] end:[dateArray objectAtIndex:1]];
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

#pragma mark---total spend
-(void)viewTotalSpend:(UITapGestureRecognizer*)sender{
    NSArray *dateArray = [[NSDate date] dateForCurrentMonth];
    DetailViewController *detailController = [[DetailViewController alloc] initWithProperty:DetailTypeSpend cid:@"" start:[dateArray objectAtIndex:0] end:[dateArray objectAtIndex:1]];
    [self.navigationController pushViewController:detailController animated:YES];
}

-(void)viewTotalIncome:(UITapGestureRecognizer*)sender{
    NSArray *dateArray = [[NSDate date] dateForCurrentMonth];
    DetailViewController *detailController = [[DetailViewController alloc] initWithProperty:DetailTypeIncome cid:@"" start:[dateArray objectAtIndex:0] end:[dateArray objectAtIndex:1]];
    [self.navigationController pushViewController:detailController animated:YES];
}

#pragma mark---Event
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    DDLogDebug(@"selected index %@",item.title);
}

#pragma mark---滚动事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollstate==0) {
        originFrame = topView.frame;
        scrollstate = 1;
    }
    CGPoint point = scrollView.contentOffset;
    if (point.y<0) {
        topView.frame=CGRectMake(originFrame.origin.x, originFrame.origin.y, 1, originFrame.size.height - point.y);
    }
    else{
        scrollstate = 0;
        topView.bounds=CGRectMake(originFrame.origin.x, originFrame.origin.y, 1, originFrame.size.height);
    }
}
@end
