//
//  DetailViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/4.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"
#import "DetailTableViewCell.h"
#import "ExpenditureDAL.h"
#import "IncomeDAL.h"
#import "SpendDetail.h"
#import "DetailModifyViewController.h"
#import "DLZAlertView.h"
#import "EnumObject.h"

@interface DetailViewController : BaseViewControler<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>{
    
    UIImageView *backView;
    UIImageView *deleteView;
    
    UITableView *tableList;
    
    UIView *totalspend;
    UILabel *totalTitle;
    UILabel *totalValue;
    
    UIView *totalincome;
    UILabel *totalincomeTitle;
    UILabel *totalincomeValue;
    
    UIView *disView;
    UIImageView *disImg;
    UIView *topView;
    
    //private property field
    DetailType pageType;
    
    NSString *categoryID;
    
    NSDate *startDate;
    NSDate *endDate;

    
    NSInteger selectedSort;
    
    //data source
    NSMutableArray *tableSource;
    NSDictionary *colorList;
    
    //if edit mode
    BOOL isDelete;
}

-(instancetype)initWithProperty:(DetailType)type cid:(NSString*)cid start:(NSDate*)start end:(NSDate*)end;

@end
