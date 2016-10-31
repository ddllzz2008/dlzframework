//
//  PackageChooseViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"

@interface PackageChooseViewController : BaseViewControler<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    
    //UI Control
    UIView *headerView;
    UIImageView *backView;
    UILabel *titleView;
    
    UITableView *tabelList;
    
    //soure
    NSMutableArray *tabelViewSource;
    NSDictionary *colorList;
}

@end
