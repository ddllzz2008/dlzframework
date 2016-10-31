//
//  BaseViewControler.h
//  DLZHelpers
//
//  Created by ddllzz2008 on 16/2/20.
//  Copyright (c) 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "FBKVOController.h"
#import "UIImage+ExtMethod.h"

@protocol AppdelegateKeyboardState

@optional
-(void)keyboardWillShow:(NSNotification *)sender;
@optional
-(void)keyboardWillHidden:(NSNotification *)sender;

@end

@protocol UIViewcontrollerArgument

@optional
-(void)receiveDataFromViewController:(UIViewController *)controller argument:(id)argument;

@end

@interface BaseViewControler : UIViewController<UITextFieldDelegate,AppdelegateKeyboardState>

@property (nonatomic,strong,readwrite) MBProgressHUD *hub;

@property (nonatomic,weak,readwrite) id<UIViewcontrollerArgument> argumentDelegate;

#pragma mark---property
-(void)hiddenTabbar;

-(void)showTabbar;

-(void)initTextFieldArray:(UIView*)view,...;

-(void)addTextFieldArray:(UIView*)view;

-(void)initControls;

-(void)initContraints;

-(void)initViewStyle;

-(void)addObservObject;

-(void)keyboardStateChanged:(BOOL)ishow view:(UIView *)view rect:(CGRect)rect;

-(FBKVOController *)fbkvo;
/*
 *-----------------获取当前系统AppDelegate------------------*
 */
-(id)getAppdelegate;
@end
