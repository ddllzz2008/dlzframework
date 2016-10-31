//
//  AppDelegate.h
//  HomeAPP
//
//  Created by 李方超 on 15/11/18.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewControler.h"
#import "DLZTabbarViewController.h"
#import "MainViewController.h"
#import "PackageViewController.h"
#import "ChartViewController.h"
#import "SettingViewController.h"
#import "AppliationLogic.h"
#import "AddViewController.h"
#import "FamilyPersonDAL.h"
#import "StoreUserDefault.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,assign) NSInteger lastTabbarIndex;
/*
 *-------------获取键盘是否打开事件---------------*
 */
-(BOOL)iskeyboardShow;
/*
 *-------------获取当前屏幕显示的viewcontroller---------------*
 */
+ (UIViewController *)getCurrentVC;

@property (nonatomic,weak) id<AppdelegateKeyboardState> keyboardDelegate;

@end

