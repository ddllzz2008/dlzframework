//
//  SettingViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    titleView = [UILabel new];
    titleView.text=NSLocalizedString(@"settingViewController_001", nil);
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
    tabelList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tabelList.separatorColor = UIColorFromRGB(color_white_01);
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tabelList setTableFooterView:v];
    [self.view addSubview:tabelList];
    [tabelList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view).with.offset(-49);
        make.width.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *v = nil;
    if (section==0) {
        v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    }
    else{
        v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    }
    [v setBackgroundColor:[UIColor clearColor]];
    
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *detailIndicated = @"settingTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detailIndicated];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailIndicated];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            [cell.textLabel setText:NSLocalizedString(@"settingViewController_005", nil)];
            cell.imageView.image = [UIImage imageNamed:@"cell_income"];
        }else if(indexPath.item==1){
            [cell.textLabel setText:NSLocalizedString(@"settingViewController_006", nil)];
            cell.imageView.image = [UIImage imageNamed:@"cell_spend"];
        }
    }else if (indexPath.section==1){
        if (indexPath.item==0) {
            [cell.textLabel setText:NSLocalizedString(@"settingViewController_007", nil)];
            cell.imageView.image = [UIImage imageNamed:@"cell_alert"];
        }else if(indexPath.item==1){
            [cell.textLabel setText:NSLocalizedString(@"settingViewController_008", nil)];
            cell.imageView.image = [UIImage imageNamed:@"cell_alarm"];
        }
    }else if (indexPath.section==2){
        if (indexPath.item==0) {
            [cell.textLabel setText:NSLocalizedString(@"settingViewController_011", nil)];
            cell.imageView.image = [UIImage imageNamed:@"cell_background"];
        }else if (indexPath.item==1){
            [cell.textLabel setText:NSLocalizedString(@"settingViewController_009", nil)];
            cell.imageView.image = [UIImage imageNamed:@"cell_delete"];
        }
    }else if (indexPath.section==3){
        [cell.textLabel setText:NSLocalizedString(@"settingViewController_010", nil)];
        cell.imageView.image = [UIImage imageNamed:@"cell_aboutus"];
    }
    [cell.textLabel styleForNormal];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *nextView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    nextView.image = [UIImage imageNamed:@"common_next"];
    cell.accessoryView = nextView;
    [cell setBackgroundColor:UIColorFromRGB(color_blue_01)];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            CategoryViewController *categorycontroller = [[CategoryViewController alloc] initWithProperty:DetailTypeIncome];
            [self.navigationController pushViewController:categorycontroller animated:YES];
        }else if(indexPath.item==1){
            CategoryViewController *categorycontroller = [[CategoryViewController alloc] initWithProperty:DetailTypeSpend];
            [self.navigationController pushViewController:categorycontroller animated:YES];
        }
    }else if (indexPath.section==1){
        if (indexPath.item==0) {
            
        }else if(indexPath.item==1){
            RemindViewController *remindcontroller = [[RemindViewController alloc] init];
            [self.navigationController pushViewController:remindcontroller animated:YES];
        }
    }else if (indexPath.section==2){
        if (indexPath.item==0) {
            UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            BackgroundViewController *backgroundController = [mainStoryboard instantiateViewControllerWithIdentifier:@"backgroundviewcontroller"];
            [self.navigationController pushViewController:backgroundController animated:YES];
        }else if (indexPath.item==1){
            
        }
    }else if (indexPath.section==3){
        
    }

}

@end
