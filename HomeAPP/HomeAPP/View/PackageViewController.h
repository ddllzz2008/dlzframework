//
//  PackageViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BaseTabbarViewController.h"
#import "DLZAlertView.h"
#import "FBKVOController.h"
#import "PackageDAL.h"
#import "PackageCompare.h"
#import "DLZCombox.h"
#import "NSString+ExtMethod.h"
#import "PackageTableViewCell.h"
#import "AddPackageView.h"
#import "MonitorApplication.h"
#import "PackageEditViewController.h"
#import "TransferViewController.h"

@interface PackageViewController : BaseTabbarViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    
    __block UIButton *selectedButton;
    
    NSString *packageName;
    NSInteger packageType;
    double packageValue;
    
    //add view Layer
    AddPackageView *packageView;
    UITextField *txtPackName;
    UITextField *txtValue;
    UIButton *addButton;
    //UI Control
    UIView *headerView;
    UIImageView *transferButton;
    UILabel *titleView;
    UIImageView *addView;
    
    UITableView *tabelList;
    
    //soure
    NSMutableArray *tabelViewSource;
    NSDictionary *colorList;
    
}

@end
