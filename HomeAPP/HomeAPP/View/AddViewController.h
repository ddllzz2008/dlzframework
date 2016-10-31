//
//  AddViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/14.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "DLZDatePicker.h"
#import "CategoryModel.h"
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

@interface AddViewController : BaseTabbarViewController<UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIViewcontrollerArgument>{
    //view controler
    UIView *headerView;
    UIImageView *backView;
    UIView *dateView;
    UILabel *dateSelected;
    UISegmentedControl *segmentView;
    UITextField *spendAccount;
    UICollectionView *categoryView;
    UISegmentedControl *segmentType;
    UILabel *categorySelected;
    UILabel *packageSelected;
    UITextField *markText;
}

@end