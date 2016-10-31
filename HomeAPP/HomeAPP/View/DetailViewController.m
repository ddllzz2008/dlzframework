//
//  DetailViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/4.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    CGRect originFrame;
    int scrollstate;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isDelete=false;
    scrollstate=0;
}

/*
 *----------------------初始化修改页面参数-------------------------------*
 */
-(instancetype)initWithProperty:(DetailType)type cid:(NSString*)cid start:(NSDate*)start end:(NSDate*)end{
    id sp = [self init];
    
    selectedSort = 0;
    
    pageType = type;
    categoryID = cid;
    startDate = start;
    endDate = end;
    
    return sp;
}

-(void)initControls{
    
    backView = [UIImageView new];
    [backView setImage:[UIImage imageNamed:@"back_blue-Small"]];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(30);
        make.left.equalTo(self.view).with.offset(10);
    }];
    
    deleteView = [UIImageView new];
    [deleteView setImage:[UIImage imageNamed:@"bar_delete-Small"]];
    [self.view addSubview:deleteView];
    [deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
    }];
    
    /*-----------本月支出------------*/
    totalspend = [UIView new];
    totalspend.layer.cornerRadius = 45;
    totalspend.clipsToBounds=YES;
    totalspend.backgroundColor = UIColorFromRGB(color_blue_01);
    [self.view addSubview:totalspend];
    [totalspend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.top.equalTo(self.view).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    totalTitle = [UILabel new];
    totalTitle.text=@"购物";
    totalTitle.textAlignment=NSTextAlignmentCenter;
    [totalTitle styleForHeader];
    [totalspend addSubview:totalTitle];
    
    [totalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalspend);
        make.top.equalTo(totalspend).with.offset(20);
        make.width.equalTo(@90);
    }];
    
    totalValue = [UILabel new];
    totalValue.text=@"0";
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
    [self.view addSubview:totalincome];
    [totalincome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-30);
        make.top.equalTo(self.view).with.offset(50);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    totalincomeTitle = [UILabel new];
    totalincomeTitle.text=@"上月";
    totalincomeTitle.textAlignment=NSTextAlignmentCenter;
    [totalincomeTitle styleForHeader];
    [totalincome addSubview:totalincomeTitle];
    
    [totalincomeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalincome);
        make.top.equalTo(totalincome).with.offset(20);
        make.width.equalTo(@90);
    }];
    
    totalincomeValue = [UILabel new];
    totalincomeValue.text=@"0";
    totalincomeValue.textAlignment=NSTextAlignmentCenter;
    [totalincomeValue styleForHeader];
    [totalincome addSubview:totalincomeValue];
    
    [totalincomeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(totalincome);
        make.bottom.equalTo(totalincome.mas_bottom).with.offset(-20);
        make.width.equalTo(@90);
    }];
    
    /*-----------中间连线------------*/
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIColorFromRGB(color_gray_01);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.left.equalTo(totalspend.mas_right).with.offset(0);
        make.right.equalTo(totalincome.mas_left).with.offset(0);
        make.centerY.equalTo(totalspend);
    }];
    
    disView = [UIView new];
    disView.layer.cornerRadius = 20;
    disView.clipsToBounds=YES;
    disView.backgroundColor = UIColorFromRGB(color_blue_02);
    [self.view addSubview:disView];
    [disView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(totalspend);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    disImg = [UIImageView new];
    [disImg setImage:[UIImage imageNamed:@"sort_time"]];
    [disView addSubview:disImg];
    [disImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(disView);
        make.width.equalTo(@30);
    }];
    /*-----------end------------*/
    
    /*-----------detail tablelist------------*/
    tableList = [UITableView new];
    tableList.delegate=self;
    tableList.dataSource=self;
    tableList.allowsSelection=YES;
    [tableList setBackgroundColor:[UIColor clearColor]];
//    tableList.bounces = NO;
    tableList.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tableList setTableFooterView:v];
    [self.view addSubview:tableList];
    [tableList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(totalspend.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(-10);
    }];
    /*-----------end------------*/
    
    /*-----------顶部连线------------*/
    topView = [UIView new];
    [topView setBackgroundColor:UIColorFromRGB(color_gray_01)];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.centerX.equalTo(disView);
        make.top.equalTo(disView.mas_bottom).with.offset(0);
        make.bottom.equalTo(tableList.mas_top).with.offset(0);
    }];
    [self.view bringSubviewToFront:topView];
    /*-----------end------------*/
    
    /*-------读取颜色列表------*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArgumentArray" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    colorList = [data objectForKey:@"ColorList"];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    backTap.delegate=self;
    backView.userInteractionEnabled=YES;
    [backView addGestureRecognizer:backTap];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenTabbar];
    
    UITapGestureRecognizer *deleteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAction:)];
    deleteTap.delegate=self;
    deleteView.userInteractionEnabled=YES;
    [deleteView addGestureRecognizer:deleteTap];
    
    if (pageType==DetailTypeIncome) {
        NSDictionary *totaldic =[[IncomeDAL Instance] getTotal:categoryID start:startDate end:endDate];
        
        if ([categoryID isBlankString]){
            if (totaldic!=nil) {
                double spend = [[totaldic objectForKey:@"MONEY"] doubleValue];
                NSString *cname = NSLocalizedString(@"addviewcontroller_014", nil);
                [totalValue setText:[NSString stringWithFormat:@"%.1f",spend]];
                [totalTitle setText:cname];
            }
        }else{
            if (totaldic!=nil) {
                double spend = [[totaldic objectForKey:@"MONEY"] doubleValue];
                NSString *cname = (NSString*)[totaldic objectForKey:@"NAME"];
                [totalValue setText:[NSString stringWithFormat:@"%.1f",spend]];
                [totalTitle setText:cname];
            }
        }
        
        tableSource = [[IncomeDAL Instance] getIncomeDetail:categoryID sort:selectedSort start:startDate end:endDate];
        
        NSArray *dateArray = [[NSDate date] dateForLastMonth];
        //上月汇总
        totaldic =[[IncomeDAL Instance] getTotal:categoryID start:[dateArray objectAtIndex:0] end:[dateArray objectAtIndex:1]];
        
        if (totaldic!=nil) {
            double spend = [[totaldic objectForKey:@"MONEY"] doubleValue];
            [totalincomeValue setText:[NSString stringWithFormat:@"%.1f",spend]];
        }
        
        
    }else if (pageType==DetailTypeSpend){
        
        NSDictionary *totaldic =[[ExpenditureDAL Instance] getTotal:categoryID start:startDate end:endDate];
        
        if ([categoryID isBlankString]) {
            if (totaldic!=nil) {
                double spend = [[totaldic objectForKey:@"MONEY"] doubleValue];
                NSString *cname = NSLocalizedString(@"addviewcontroller_013", nil);
                [totalValue setText:[NSString stringWithFormat:@"%.1f",spend]];
                [totalTitle setText:cname];
            }
        }else{
            if (totaldic!=nil) {
                double spend = [[totaldic objectForKey:@"MONEY"] doubleValue];
                NSString *cname = (NSString*)[totaldic objectForKey:@"NAME"];
                [totalValue setText:[NSString stringWithFormat:@"%.1f",spend]];
                [totalTitle setText:cname];
            }
        }
        
        tableSource = [[ExpenditureDAL Instance] getExpenditureDetail:categoryID sort:selectedSort start:startDate end:endDate
                       ];
        
        NSArray *dateArray = [[NSDate date] dateForLastMonth];
        //上月汇总
        totaldic =[[ExpenditureDAL Instance] getTotal:categoryID start:[dateArray objectAtIndex:0] end:[dateArray objectAtIndex:1]];
        
        if (totaldic!=nil) {
            double spend = [[totaldic objectForKey:@"MONEY"] doubleValue];
            [totalincomeValue setText:[NSString stringWithFormat:@"%.1f",spend]];
        }
    }
    [tableList reloadData];
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
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTableViewCell *cell = [DetailTableViewCell cellWithTableView:tableView];
    
    SpendDetail *detail = [tableSource objectAtIndex:indexPath.item];
    
    NSString *colorString = [colorList objectForKey:detail.PCOLOR];
    unsigned long color = strtoul([colorString UTF8String],0,16);
    [cell setCenterColor:color];
    if (indexPath.item%2==0) {
        [cell setLeftvalue:[NSString stringWithFormat:@"%.1f",detail.EVALUE]];
        [cell setLeftMark:detail.IMARK];
        [cell setRightvalue:detail.PNAME];
//        [cell setRightColor:UIColorFromRGB(color_gray_01)];
        [cell setRightMark:[[detail.CREATETIME convertDateFromString:dateformat_07] formatWithCode:dateformat_10]];
//        [cell setRightMarkColor:UIColorFromRGB(color_gray_01)];
    }
    else{
        [cell setRightvalue:[NSString stringWithFormat:@"%.1f",detail.EVALUE]];
        [cell setRightMark:detail.IMARK];
        [cell setLeftvalue:detail.PNAME];
//        [cell setLeftColor:UIColorFromRGB(color_gray_01)];
        [cell setLeftMark:[[detail.CREATETIME convertDateFromString:dateformat_07] formatWithCode:dateformat_10]];
//        [cell setLeftMarkColor:UIColorFromRGB(color_gray_01)];
    }
    if (isDelete) {
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [deleteBtn setTag:indexPath.item];
        [deleteBtn setTitle:@"×" forState:UIControlStateNormal];
        [deleteBtn.titleLabel styleForNormal];
        [deleteBtn addTarget:self action:@selector(deleteData:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tintColor=UIColorFromRGB(color_white_01);
        [cell showDeleteButton:deleteBtn];
    }else{
        [cell hiddenDeleteButton];
    }
    //隐藏最后一行的下线
    if (indexPath.item==tableSource.count-1) {
        [cell hiddenBottom];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpendDetail *detail = [tableSource objectAtIndex:indexPath.item];
    if (detail!=nil) {
        DetailModifyViewController *modifyController = [[DetailModifyViewController alloc] initWithProperty:pageType eid:detail.EID];
        [self.navigationController pushViewController:modifyController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *-----------------返回------------------*
 */
-(void)backAction:(UITapGestureRecognizer*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
 *-----------------删除数据------------------*
 */
-(void)deleteAction:(UITapGestureRecognizer*)sender{
    if (isDelete) {
        isDelete=NO;
        tableList.allowsSelection=YES;
        [deleteView setImage:[UIImage imageNamed:@"bar_delete-Small"]];
    }else{
        isDelete=YES;
        tableList.allowsSelection=NO;
        [deleteView setImage:[UIImage imageNamed:@"common_save-Small"]];
    }
    [tableList reloadData];
    
}

-(void)deleteData:(UIButton*)sender{
    @try {
        [DLZAlertView showAlertMessage:self.tabBarController title:NSLocalizedString(@"common_warning", nil) content:NSLocalizedString(@"common_confirmdelete", nil) leftButton:NSLocalizedString(@"common_cancel", nil) leftaction:^(id left) {
            DLZAlertView *view = left;
            [view removeFromSuperview];
        } rightButton:NSLocalizedString(@"common_confirm", nil) rightaction:^(id right) {
            int tag = sender.tag;
            SpendDetail *detail = [tableSource objectAtIndex:tag];
            if (detail!=nil) {
                BOOL state=NO;
                if (pageType==DetailTypeIncome) {
                    state = [[IncomeDAL Instance] deleteIncome:detail.EID pid:detail.PID evalue:detail.EVALUE];
                }else if (pageType==DetailTypeSpend){
                    state = [[ExpenditureDAL Instance] deleteExpenditure:detail.EID pid:detail.PID evalue:detail.EVALUE];
                }
                if (state) {
                    [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savesuccess", nil)];
                    [tableSource removeObject:detail];
                    [tableList reloadData];
                }else{
                    [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savefailed", nil)];
                }
                
            }
            DLZAlertView *view = right;
            [view removeFromSuperview];
        }];
    }
    @catch (NSException *exception) {
        DDLogError(@"%@",exception);
    }
    @finally {
        
    }
    
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
        topView.bounds=CGRectMake(originFrame.origin.x, originFrame.origin.y, 1, 25);
    }
}
@end
