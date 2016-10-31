//
//  MdyCategoryViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/27.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MdyCategoryViewController.h"

@interface MdyCategoryViewController ()

@end

@implementation MdyCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    packageColor = 1;
    
    /*--------添加要取消的输入框集合--------*/
    [self addTextFieldArray:self.utfCategoryName];
    /*--------end--------*/
}
/*
 *----------------------初始化修改页面参数-------------------------------*
 */
-(instancetype)initWithProperty:(BOOL)add ioe:(NSInteger)ioe cm:(CategoryModel *)cm{
    id sp = [self init];
    isAdd = add;
    model = cm;
    incomeOrExpend = ioe;
    return sp;
}

/*
 *----------------------初始化控件-------------------------------*
 */
-(void)initControls{
    /*--------头部--------*/
    UIView *headerView = [UIView new];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    UIView *headerBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenSize.width, 1)];
    headerBorder.backgroundColor=UIColorFromRGB(color_gray_02);
    [headerView addSubview:headerBorder];
    
    self.backView = [UIImageView new];
    [self.backView setImage:[UIImage imageNamed:@"back_blue-Small"]];
    [headerView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).with.offset(10);
    }];
    
    UILabel *headerTitle = [UILabel new];
    if (isAdd) {
        [headerTitle setText:NSLocalizedString(@"mdycategoryviewcontroller_003", nil)];
    }else{
        [headerTitle setText:NSLocalizedString(@"mdycategoryviewcontroller_001", nil)];
    }
    headerTitle.textAlignment=NSTextAlignmentCenter;
    [headerTitle styleForTitle];
    [headerView addSubview:headerTitle];
    [headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.width.equalTo(@150);
    }];
    
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTitle:NSLocalizedString(@"common_save", nil) forState:UIControlStateNormal];
    confirmBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [confirmBtn styleForHeader];
    [headerView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).with.offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(headerView);
    }];
    [confirmBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    /*--------end--------*/
    
    /*--------类别名称--------*/
    self.categoryView = [UIView new];
    self.categoryView.backgroundColor = UIColorFromRGB(color_blue_01);
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
        make.top.equalTo(headerView.mas_bottom).with.offset(10);
    }];
    
    UILabel *categoryTitle = [UILabel new];
    [categoryTitle setText:NSLocalizedString(@"mdycategoryviewcontroller_002", nil)];
    [categoryTitle styleForNormal];
    CGSize categoryTitleSize = [categoryTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    categoryTitleSize = CGSizeMake(categoryTitleSize.width+10, categoryTitleSize.height);
    [self.categoryView addSubview:categoryTitle];
    [categoryTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.categoryView);
        make.left.equalTo(self.categoryView).with.offset(10);
        make.size.mas_equalTo(categoryTitleSize);
    }];
    
    self.utfCategoryName = [UITextField new];
    [self.utfCategoryName setBackgroundColor:UIColorFromRGB(color_white_01)];
    self.utfCategoryName.textAlignment=NSTextAlignmentRight;
    self.utfCategoryName.keyboardType=UIKeyboardTypeDefault;
    self.utfCategoryName.returnKeyType=UIReturnKeyDone;
//    [self.utfCategoryName setPlaceholder:NSLocalizedString(@"addviewcontroller_008", nil)];
    [self.categoryView addSubview:self.utfCategoryName];
    [self.utfCategoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(categoryTitle.mas_right).with.offset(5);
        make.right.equalTo(self.categoryView.mas_right).with.offset(-5);
        make.centerY.equalTo(self.categoryView);
        make.height.equalTo(@30);
    }];
    /*--------end--------*/
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    backTap.delegate=self;
    self.backView.userInteractionEnabled=YES;
    [self.backView addGestureRecognizer:backTap];
    
    if (model!=nil) {
        [self.utfCategoryName setText:model.CNAME];
    }
    
    /*--------类型颜色--------*/
    /*-------读取颜色列表------*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArgumentArray" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    colorList = [data objectForKey:@"ColorList"];
    int colorIndex = 1;
    int space = 5;
    __block double wh = (ScreenSize.width -5*6)/5;
    UIButton *lastButton = nil;
    for (NSString *key in colorList) {
        UIButton *colorButton = [UIButton new];
        
        int line = (colorIndex-1)/5 + 1;
        
        NSString *colorString = [colorList objectForKey:key];
        
        unsigned long colorValue = strtoul([colorString UTF8String],0,16);
        
        [colorButton setBackgroundColor:UIColorFromRGB(colorValue)];
        
        [colorButton addTarget:self action:@selector(choosePackageType:) forControlEvents:UIControlEventTouchUpInside];
        
        [colorButton setTag:[key intValue]];
        
        if (model!=nil) {
            if (colorIndex == [model.CCOLOR intValue]) {
                packageColor = colorIndex;
                selectedButton = colorButton;
                colorButton.layer.borderWidth = 2;
                colorButton.layer.borderColor = [UIColor grayColor].CGColor;
            }
        }else{
            if (colorIndex == 1) {
                packageColor = colorIndex;
                selectedButton = colorButton;
                colorButton.layer.borderWidth = 2;
                colorButton.layer.borderColor = [UIColor grayColor].CGColor;
            }
        }
        
        [self.view addSubview:colorButton];
        
        __block double marginTop = line * space + (line-1) * wh;
        
        __block double marginLeft = 0;
        
        int item = colorIndex % 5;
        if (item ==0) {
            marginLeft = 5 * space + (5 - 1) * wh;
        }else{
            marginLeft = item* space + (item - 1) * wh;
        }
        
        [colorButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(wh, wh));
            make.top.equalTo(self.categoryView.mas_bottom).with.offset(marginTop);
            make.left.equalTo(self.view).with.offset(marginLeft);
        }];
        
        lastButton = colorButton;
        
        colorIndex++;
    }
    /*--------end--------*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark---save logic
/*
 *--------------选择颜色----------------*
 */
-(void)choosePackageType:(UIButton*)btn{
    if (selectedButton!=nil) {
        selectedButton.layer.borderWidth = 0;
    }
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    selectedButton = btn;
    packageColor = [selectedButton tag];
}
/*
 *-----------------保存修改------------------*
 */
-(void)saveAction:(id)sender{
    self.hub = [[AlertController sharedInstance] showMessage:self.view message:NSLocalizedString(@"common_saving", nil)];
    if (isAdd) {
        CategoryModel *categoryModel = [[CategoryDAL Instance] addCategory:self.utfCategoryName.text color:[NSString stringWithFormat:@"%ld",(long)packageColor] type:incomeOrExpend createtime:[[NSDate date] formatWithCode:dateformat_07]];
        if (categoryModel!=nil) {
            [[AlertController sharedInstance] closeMessage:self.hub];
            if (self.argumentDelegate !=nil) {
                [self.argumentDelegate receiveDataFromViewController:self argument:categoryModel];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savefailed", nil)];
        }
    }else{
        BOOL state = [[CategoryDAL Instance] updateCategory:model.CID name:self.utfCategoryName.text color:[NSString stringWithFormat:@"%ld",(long)packageColor]];
        if (state) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savefailed", nil)];
        }
    }
}
/*
 *-----------------返回------------------*
 */
-(void)backAction:(UITapGestureRecognizer*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
