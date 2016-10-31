//
//  DLZDatePicker.h
//  DLZControls
//
//  Created by ddllzz on 16/4/3.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+extmethod.h"
#import "NSString+ExtMethod.h"
#import "NSDate+ExtMethod.h"
#import "DLZDatePickerViewController.h"

typedef NS_ENUM(NSInteger,DLZDatePickerRange){
    DLZDatePickerRangeCurrentWeek=0,
    DLZDatePickerRangeLastWeek=1,
    DLZDatePickerRangeCurrentMonth=2,
    DLZDatePickerRangeLastMonth=3,
    DLZDatePickerRangeCurrentYear =4,
    DLZDatePickerRangeCustomer=5,
};

@protocol DLZDatePickerDelegate <NSObject>

@optional
-(void)DLZDatePicker:(NSDate*)startDate endDate:(NSDate*)endDate;

@end

@interface DLZDatePicker : UIView<UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSDate *startDate;

@property (nonatomic,strong) NSDate *endDate;

@property (nonatomic) DLZDatePickerRange selectedRange;

@property (nonatomic,weak) UIColor *textColor;

@property (nonatomic,weak) UIFont *font;

@property (nonatomic,weak) UIViewController *currentViewController;

@property (nonatomic,weak) id<DLZDatePickerDelegate> delegate;

+(void)showActionDateSheet:(UIView*)root date:(NSDate *)date chooseCallBack:(void (^)(NSArray*))chooseCallBack;

+(void)setSheetActionDictionary:(NSDictionary*)dic;
+(NSDictionary*)getSheetActionDictionary;

@end
