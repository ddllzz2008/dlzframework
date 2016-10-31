//
//  DLZTabbarViewController.m
//  DLZControls
//
//  Created by ddllzz on 16/3/24.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DLZTabbarViewController.h"

@interface DLZTabbarViewController ()

-(void)initContraints;

@end

@implementation DLZTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
    button.center = CGPointMake(ScreenSize.width/2, 22);
    [button setBackgroundImage:[UIImage imageNamed:@"tab_add"] forState:UIControlStateNormal];
    [self.tabBar addSubview:button];
    
//    UIImage *bg = [UIImage imageNamed:@"tab_background.png"];
//    [self.tabBar setBackgroundImage:bg];
    
//    UIImage *trap = [UIImage imageNamed:@"transparent"];
//    [self.tabBar setShadowImage:trap];
    
    self.tabBar.selectedImageTintColor = UIColorFromRGB(0x10D4FE);
    
    [self.tabBar setTranslucent:YES];
    
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self initControls];
    
    [self initViewStyle];
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self initContraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    [tabBarController setDelegate:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self removeObserver:self forKeyPath:@"selectedIndex"];
    
    [super viewWillDisappear:animated];
}

-(UINavigationController*)addViewController:(NSString*)title image:(UIImage*)image viewcontroller:(UIViewController*)viewcontroller{
    viewcontroller.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    viewcontroller.title=title;
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
    nav.navigationBarHidden=YES;
    
//    if (image!=nil) {
//        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenSize.height-self.tabBar.frame.size.height-1, ScreenSize.width, 1)];
//        borderView.layer.borderWidth=1;
//        borderView.layer.borderColor=UIColorFromRGB(0x10D5FF).CGColor;
//        [nav.view addSubview:borderView];
//    }
    
    return nav;
}

#pragma mark---monitor selected changed
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selectedIndex"]) {
        int _new = [[change objectForKey:@"new"] intValue];
        switch (_new) {
            case 0:
            case 1:
            case 3:
            case 4:
                [self.tabBar setHidden:NO];
                self.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 49);
                break;
            case 2:
                [self.tabBar setHidden:YES];
                self.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 0);
                break;
        }
    }
}

-(void)tabBar:(UITabBar*)atabBar didSelectItem:(UITabBarItem*)item
{
    if (item.title==nil) {
        CATransition* animation = [CATransition animation];
        [animation setDuration:0.4f];
        [animation setType:kCATransitionMoveIn];
        [animation setSubtype:kCATransitionFromTop];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [[self.view layer]addAnimation:animation forKey:@"switchView"];
    }
}

//init view constraints
-(void)initContraints{}

-(void)initViewStyle{}

-(void)initControls{}

@end
