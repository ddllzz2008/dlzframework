//
//  DLZAlertView.h
//  DLZControls
//
//  Created by ddllzz on 16/5/10.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"
#import "UILabel+extmethod.h"

typedef void(^DLZAlertViewCallback)(id sender);

@interface DLZAlertView : UIView<UIGestureRecognizerDelegate>{
    UIView *hiddenView;
    UIView *contentView;
    UIImageView *closeView;
    
    UILabel *viewTitle;
    UILabel *viewContent;
    
    UIButton *leftButton;
    UIButton *rightButton;
}

+(void)showAlertMessage:(UIViewController*)controller title:(NSString*)title content:(NSString*)content leftButton:(NSString*)leftButton leftaction:(void (^)(id sender))leftaction rightButton:(NSString*)rightButton rightaction:(void (^)(id sender))rightaction;

@property (nonatomic,copy) DLZAlertViewCallback leftButtonAction;

@property (nonatomic,copy) DLZAlertViewCallback rightButtonAction;

@end
