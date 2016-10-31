//
//  SettingViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "CategoryViewController.h"
#import "RemindViewController.h"
#import "BackgroundViewController.h"

@interface SettingViewController : BaseTabbarViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    //UI Control
    UIView *headerView;
    UILabel *titleView;
    UITableView *tabelList;
}

@end
