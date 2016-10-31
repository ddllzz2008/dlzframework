//
//  BackgroundViewController.h
//  HomeAPP
//
//  Created by ddllzz on 16/8/3.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"

@interface BackgroundViewController : BaseViewControler<UIGestureRecognizerDelegate>


@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UILabel *titleView;

@property (strong, nonatomic) IBOutlet UIView *headerBorder;

@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@property (strong, nonatomic) IBOutlet UIImageView *backView;


@end
