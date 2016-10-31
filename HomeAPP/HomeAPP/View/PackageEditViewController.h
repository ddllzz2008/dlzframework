//
//  PackageEditViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/10.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"
#import "PackageCompare.h"

@interface PackageEditViewController : BaseViewControler<UIGestureRecognizerDelegate>{
    
    UIButton *selectedButton;
    
    NSInteger packageColor;
    
    NSDictionary *colorList;
    //ture：添加  false：修改
    BOOL isAdd;
    
    PackageCompare *model;
}

@property (nonatomic,strong,readwrite) UIImageView *backView;

@property (nonatomic,strong,readwrite) UITextField *utfCategoryName;

@property (nonatomic,strong,readwrite) UITextField *utfBalance;

@property (nonatomic,strong,readwrite) UIView *categoryView;

@property (nonatomic,strong,readwrite) UIView *balanceView;

-(instancetype)initWithProperty:(BOOL)add cm:(PackageCompare *)cm;

@end
