//
//  DLZTabbarViewController.h
//  DLZControls
//
//  Created by ddllzz on 16/3/24.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLZTabbarViewController : UITabBarController<UITabBarControllerDelegate>

-(void)initControls;

-(void)initContraints;

-(void)initViewStyle;

-(UINavigationController*)addViewController:(NSString*)title image:(UIImage*)image viewcontroller:(UIViewController*)viewcontroller;

@end
