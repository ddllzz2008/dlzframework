//
//  AppDelegate.m
//  HomeAPP
//
//  Created by 李方超 on 15/11/18.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (){
    BOOL _iskeyboardShow;
}

@end

@implementation AppDelegate

/*
 *-------------获取键盘是否打开事件---------------*
 */
-(BOOL)iskeyboardShow{
    return _iskeyboardShow;
}

/*
 *-------------获取当前屏幕显示的viewcontroller---------------*
 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];

    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [[AlertController sharedInstance] showMessageAutoClose:[AppDelegate getCurrentVC].view message:@"no internet"];
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //初始化下载配置信息数据
    [AppliationLogic createDatabase];
    //保存家庭成员信息至本地存储
    NSArray *familyArray = [[FamilyPersonDAL Instance] getFamilyPersons];
    if (familyArray) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:familyArray];
        [[StoreUserDefault instance] setData:datastore_familyArray data:data];
    }
    //init start page
    _window =[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    DLZTabbarViewController *tabBarController = [[DLZTabbarViewController alloc] init];
    UIImage *img1 = [UIImage imageNamed:@"tab_chart.png"];
    UIImage *img2 = [UIImage imageNamed:@"tab_money.png"];
    UIImage *img3 = [UIImage imageNamed:@"tab_family.png"];
    UIImage *img4 = [UIImage imageNamed:@"tab_setting.png"];
    tabBarController.viewControllers = [NSArray arrayWithObjects:
        [tabBarController addViewController:NSLocalizedString(@"tabbar_item1",nil) image:img1 viewcontroller:[[MainViewController alloc] init]],
        [tabBarController addViewController:NSLocalizedString(@"tabbar_item2",nil) image:img2 viewcontroller:[[PackageViewController alloc] init]],
        [tabBarController addViewController:nil image:nil viewcontroller:[[AddViewController alloc] init]],
        [tabBarController addViewController:NSLocalizedString(@"tabbar_item3",nil) image:img3 viewcontroller:[[ChartViewController alloc] init]],
        [tabBarController addViewController:NSLocalizedString(@"tabbar_item4",nil) image:img4 viewcontroller:[[SettingViewController alloc] init]],nil];
    for (UIViewController *controller in tabBarController.viewControllers) {
        UIView *view = controller.view;
    }
    
    _window.rootViewController=tabBarController;
    [_window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}

#pragma mark---注册键盘打开关闭监听事件
-(void)keyboardWillShow:(NSNotification *)sender{
    _iskeyboardShow=YES;
    if (self.keyboardDelegate!=nil) {
        [self.keyboardDelegate keyboardWillShow:sender];
    }
}

-(void)keyboardWillHide:(NSNotification *)sender{
    _iskeyboardShow=NO;
    if (self.keyboardDelegate!=nil) {
        [self.keyboardDelegate keyboardWillHidden:sender];
    }
}

@end
