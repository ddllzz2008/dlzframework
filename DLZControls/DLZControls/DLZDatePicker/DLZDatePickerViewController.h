//
//  DLZDatePickerViewController.h
//  DLZControls
//
//  Created by ddllzz on 16/4/8.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+ExtMethod.h"

@interface DLZDatePickerViewController : UIViewController<UINavigationBarDelegate>

#pragma mark---UI Layout

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerForStart;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerForEnd;

#pragma mark---UIControl refrence

#pragma mark--Property
@property (nonatomic,readwrite) NSInteger selectedIndex;

@property (nonatomic,weak,readwrite) NSDate *startDate;

@property (nonatomic,weak,readwrite) NSDate *endDate;

@end
