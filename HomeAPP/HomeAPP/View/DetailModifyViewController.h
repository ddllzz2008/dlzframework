//
//  DetailModifyViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/17.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "DLZDatePicker.h"
#import "BusExpenditure.h"
#import "BusIncome.h"
#import "CategoryDAL.h"
#import "CategoryCollectionViewCell.h"
#import "UIView+ExtMethod.h"
#import "StoreUserDefault.h"
#import "FamilyPerson.h"
#import "ExpenditureDAL.h"
#import "IncomeDAL.h"
#import "PackageDAL.h"
#import "PackageCompare.h"
#import "MdyCategoryViewController.h"

@interface DetailModifyViewController : BaseViewControler<UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIViewcontrollerArgument>{
    //view controler
    UIView *headerView;
    UIImageView *backView;
    UIView *dateView;
    UILabel *dateSelected;
    UILabel *titleView;
    UITextField *spendAccount;
    UICollectionView *categoryView;
    UISegmentedControl *segmentType;
    UILabel *categorySelected;
    UILabel *packageSelected;
    UITextField *markText;
}

/*
 *----------------------初始化修改页面参数-------------------------------*
 */
-(instancetype)initWithProperty:(int)type eid:(NSString*)eid;

@end
