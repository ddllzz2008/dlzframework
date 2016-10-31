//
//  BaseTabbarViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/27.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "BaseTabbarViewController.h"

@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    [tabBarController setDelegate:self];
    
    [self.tabBarController.tabBar setBackgroundColor:[UIColor clearColor]];
    
    NSString *resPath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/Themes/category1"];
    if (resPath) {
        UIImage *backgroundImg = [UIImage imageWithContentsOfFile:[resPath stringByAppendingPathComponent:@"category1_1.png"]];
        UIImage *scaleImg = [backgroundImg scaleToSize:ScreenSize];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:scaleImg]];
    }

//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"category1_1"]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 *------------------获取UITabbar最后选择的索引-----------------*
 */
-(NSInteger)getlastTabIndex{
    NSInteger lindex = ((AppDelegate *)[self getAppdelegate]).lastTabbarIndex;
    if (lindex<0) {
        ((AppDelegate *)[self getAppdelegate]).lastTabbarIndex = 0;
        lindex = 0;
    }
    return lindex;
}
/*
 *------------------拦截选择事件-----------------*
 */
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = tabBarController.selectedIndex;
    switch (index) {
        case 0:
        case 1:
        case 3:
        case 4:
            ((AppDelegate *)[self getAppdelegate]).lastTabbarIndex = tabBarController.selectedIndex;
            [tabBarController.tabBar setHidden:NO];
            tabBarController.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 49);
            break;
        case 2:
            [tabBarController.tabBar setHidden:YES];
            tabBarController.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 0);
            break;
    }
}

@end
