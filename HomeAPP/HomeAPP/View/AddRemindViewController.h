//
//  AddRemindViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/23.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"
#import "LocalNotificationHelper.h"
#import "NSString+ExtMethod.h"
#import "DLZCombox.h"
#import "RemindDAL.h"

@interface AddRemindViewController : BaseViewControler<UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,DLZComboxDelegate>{
    //UI Control
    UIView *headerView;
    UIImageView *backView;
    UILabel *titleView;
    
    UIPickerView *timePicker;
    
    DLZCombox *typeCombox;
    DLZCombox *typeDayCombox;
    
    UITextField *markText;
}

@end
