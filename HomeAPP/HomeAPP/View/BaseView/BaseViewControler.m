//
//  BaseViewControler.m
//  DLZHelpers
//
//  Created by ddllzz2008 on 16/2/20.
//  Copyright (c) 2016年 李方超. All rights reserved.
//

#import "BaseViewControler.h"

@interface BaseViewControler(){
    
    NSMutableArray *textfieldArray;
    
    FBKVOController *fbkvo;
}

@end

@implementation BaseViewControler

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSString *resPath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"/Themes/category1"];
    if (resPath) {
        UIImage *backgroundImg = [UIImage imageWithContentsOfFile:[resPath stringByAppendingPathComponent:@"category1_1.png"]];
        UIImage *scaleImg = [backgroundImg scaleToSize:ScreenSize];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:scaleImg]];
    }
    
    [self initControls];
    [self initViewStyle];
    
    fbkvo = [FBKVOController controllerWithObserver:self];
    
    [self addObservObject];
    
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background1"]];
//    backgroundImage.frame=CGRectMake(0, 0, ScreenSize.width, ScreenSize.height);
//    [self.view addSubview:backgroundImage];
//    [self.view sendSubviewToBack:backgroundImage];
    
        
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    self.hub = nil;
    if (fbkvo!=nil) {
        [fbkvo unobserveAll];
    }
    fbkvo = nil;
    
    currentResponser = nil;
}
/*
 *------------------隐藏工具栏-----------------*
 */
-(void)hiddenTabbar{
    [self.tabBarController.tabBar setHidden:YES];
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 0);
//    NSArray *subviews = [self.navigationController.view subviews];
//    if (subviews.count>1) {
//        [[subviews objectAtIndex:subviews.count-1] setHidden:YES];
//    }
}
/*
 *------------------显示工具栏-----------------*
 */
-(void)showTabbar{
    [self.tabBarController.tabBar setHidden:NO];
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 49);
//    NSArray *subviews = [self.navigationController.view subviews];
//    if (subviews.count>1) {
//        [[subviews objectAtIndex:subviews.count-1] setHidden:NO];
//    }
}
/*
 *------------------初始化要缩回的键盘集合-----------------*
 */
-(void)initTextFieldArray:(UIView*)view,...{
    textfieldArray = [[NSMutableArray alloc] init];
    UIView *v;
    va_list arg_list;
    va_start(arg_list, view);
    while ((v = va_arg(arg_list, UIView *))) {
        if (view==nil) {
            continue;
        }
        if ([v isKindOfClass:[UITextField class]]) {
            [textfieldArray addObject:v];
            ((UITextField *)v).delegate=self;
        }
    }
    va_end(arg_list);
}
/*
 *------------------添加要缩回的键盘集合-----------------*
 */
-(void)addTextFieldArray:(UIView*)view{
    if (textfieldArray==nil) {
        textfieldArray = [[NSMutableArray alloc] init];
    }
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField *utf = (UITextField *)view;
        utf.delegate = self;
    }
    [textfieldArray addObject:view];
}

/*
 *------------------添加UIView约束-----------------*
 */
-(void)initContraints{}
/*
 *------------------初始化UIView样式-----------------*
 */
-(void)initViewStyle{}

/*
 *------------------初始化控件-----------------*
 */
-(void)initControls{}

/*
 *------------------添加观察者对象-----------------*
 */
-(void)addObservObject{};
/*
 *------------------处理键盘打开或隐藏事件-----------------*
 */
-(void)keyboardStateChanged:(BOOL)ishow view:(UIView *)view rect:(CGRect)rect{};
/*
 *------------------收起键盘-----------------*
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (textfieldArray!=nil) {
        for (UIView* textfield in textfieldArray) {
            [textfield resignFirstResponder];
        }
    }
}

#pragma mark---键盘打开和隐藏协议
UITextField *currentResponser;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    currentResponser = textField;
    return YES;
}

-(void)keyboardWillShow:(NSNotification *)sender{
    NSDictionary *userInfo = [sender userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    [self keyboardStateChanged:YES view:currentResponser rect:keyboardRect];
}

-(void)keyboardWillHidden:(NSNotification *)sender{
    [self keyboardStateChanged:NO view:currentResponser rect:CGRectMake(0, 0, 0, 0)];
}

/*
 *-----------------获取当前系统AppDelegate------------------*
 */
-(id)getAppdelegate{
    return [[UIApplication sharedApplication] delegate];
}
/*
 *-----------------获取当前监控者------------------*
 */
-(FBKVOController *)fbkvo{
    return fbkvo;
}
@end
