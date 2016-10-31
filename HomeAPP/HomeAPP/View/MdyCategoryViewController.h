//
//  MdyCategoryViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/27.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"

@interface MdyCategoryViewController : BaseViewControler<UIGestureRecognizerDelegate>{
    
    UIButton *selectedButton;
    
    NSInteger packageColor;
    
    NSDictionary *colorList;
    //ture：添加  false：修改
    BOOL isAdd;
    //收入或支出,0:支出，1:收入
    NSInteger incomeOrExpend;
    
    CategoryModel *model;
}

@property (nonatomic,strong,readwrite) UIImageView *backView;

@property (nonatomic,strong,readwrite) UITextField *utfCategoryName;

@property (nonatomic,strong,readwrite) UIView *categoryView;

-(instancetype)initWithProperty:(BOOL)add ioe:(NSInteger)ioe cm:(CategoryModel *)cm;

@end
