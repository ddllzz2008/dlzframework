//
//  CategoryViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/20.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"
#import "CategoryTableViewCell.h"
#import "EnumObject.h"
#import "CategoryModel.h"
#import "DLZAlertView.h"

@interface CategoryViewController : BaseViewControler<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    
    //UI Control
    UIView *headerView;
    UIImageView *backView;
    UILabel *titleView;
    
    UITableView *tabelList;
    
    //soure
    NSMutableArray *typeSource;
    NSDictionary *colorList;
    
    //property
    DetailType type;
}

-(instancetype)initWithProperty:(DetailType)ty;

@end
