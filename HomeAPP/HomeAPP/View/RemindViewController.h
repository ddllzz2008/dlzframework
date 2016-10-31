//
//  RemindViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/23.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"
#import "AddRemindViewController.h"
#import "RemindTableViewCell.h"
#import "LocalNotificationHelper.h"

@interface RemindViewController : BaseViewControler<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    //UI Control
    UIView *headerView;
    UILabel *titleView;
    UITableView *tabelList;
}

@end
