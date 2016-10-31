//
//  TransferViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/18.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"
#import "PackageChooseViewController.h"
#import "PackageCompare.h"
#import "TransferDAL.h"

@interface TransferViewController : BaseViewControler<UIGestureRecognizerDelegate,UIViewcontrollerArgument>{
    //UI Control
    UIView *headerView;
    UIImageView *backView;
    UILabel *titleView;
    
    UIButton *buttonFrom;
    UIButton *buttonTo;
    UITextField *txtMoney;
    
    NSDictionary *colorList;
}

@end
