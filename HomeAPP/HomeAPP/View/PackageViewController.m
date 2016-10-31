//
//  PackageViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/3/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "PackageViewController.h"
@interface PackageViewController(){
    PackageTableViewCell *editCell;
    BOOL isEdit;
}
@end

@implementation PackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isEdit = NO;
}

-(void)initControls{
    //init view control
    headerView = [UIView new];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    UIView *headerBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenSize.width, 1)];
    headerBorder.backgroundColor=UIColorFromRGB(color_gray_02);
    [headerView addSubview:headerBorder];
    
    transferButton = [UIImageView new];
    [transferButton setImage:[UIImage imageNamed:@"icon_change"]];
    [headerView addSubview:transferButton];
    [transferButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(28, 28));
        make.left.equalTo(headerView).with.offset(10);
    }];
    
    titleView = [UILabel new];
    titleView.text=@"我的钱包";
    titleView.textAlignment=NSTextAlignmentCenter;
    [titleView styleForTitle];
    [headerView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.width.equalTo(@150);
    }];
    
    addView = [UIImageView new];
    [addView setImage:[UIImage imageNamed:@"nav_add-Samll"]];
    [headerView addSubview:addView];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(29, 29));
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView.mas_right).with.offset(-10);
    }];
    
//    DLZCombox *cbox = [DLZCombox new];
//    cbox.backgroundColor=UIColorFromRGB(color_blue_01);
//    cbox.layer.cornerRadius = 4;
//    cbox.clipsToBounds=YES;
//    cbox.textColor=UIColorFromRGB(color_white_01);
//    cbox.font=[UIFont fontWithName:@"Arial" size:14];
//    cbox.source=[NSArray arrayWithObjects:@"余额",@"支出",@"收入",nil];
//    cbox.delegate=self;
//    [self.view addSubview:cbox];
//    [cbox mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).with.offset(10);
//        make.top.equalTo(headerView.mas_bottom).with.offset(10);
//        make.right.equalTo(self.view.mas_right).with.offset(-10);
//        make.height.equalTo(@30);
//    }];
    
    tabelList = [UITableView new];
    tabelList.delegate=self;
    tabelList.dataSource=self;
    tabelList.allowsSelection=NO;
    [tabelList setBackgroundColor:[UIColor clearColor]];
    tabelList.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [tabelList setTableFooterView:v];
    [self.view addSubview:tabelList];
    [tabelList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.view).with.offset(-49);
        make.width.equalTo(self.view);
    }];
    
//    [self.view bringSubviewToFront:cbox];
    
    /*--------绘制添加钱包的图层--------*/
    packageView = [[AddPackageView alloc]initWithFrame:CGRectMake(ScreenSize.width/6, -75, ScreenSize.width*2/3, 250)];
    [packageView setBackgroundColor:[UIColor clearColor]];
    [packageView.layer setAnchorPoint:CGPointMake(0.5, 0)];
    packageView.alpha=0.0;
    [self.view addSubview:packageView];
    
    txtPackName = [UITextField new];
    txtPackName.returnKeyType = UIReturnKeyDone;
    txtPackName.layer.borderColor = UIColorFromRGB(color_gray_02).CGColor;
    txtPackName.layer.borderWidth =1.0;
    txtPackName.layer.cornerRadius =5.0;
    txtPackName.placeholder=NSLocalizedString(@"packageViewController_001", nil);
    [packageView addSubview:txtPackName];
    [txtPackName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(packageView).with.offset(5);
        make.right.equalTo(packageView).with.offset(-5);
        make.top.equalTo(packageView).with.offset(25);
        make.height.equalTo(@35);
    }];
    
    txtValue = [UITextField new];
    txtValue.layer.borderColor = UIColorFromRGB(color_gray_02).CGColor;
    txtValue.layer.borderWidth =1.0;
    txtValue.layer.cornerRadius =5.0;
    txtValue.keyboardType=UIKeyboardTypeNumberPad;
    txtValue.placeholder=NSLocalizedString(@"packageViewController_003", nil);
    [packageView addSubview:txtValue];
    [txtValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(packageView).with.offset(5);
        make.right.equalTo(packageView).with.offset(-5);
        make.top.equalTo(txtPackName.mas_bottom).with.offset(5);
        make.height.equalTo(@35);
    }];
    
    /*-------读取颜色列表------*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArgumentArray" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    colorList = [data objectForKey:@"ColorList"];
    int colorIndex = 1;
    int space = 5;
    __block double wh = (ScreenSize.width*2/3 -5*6)/5;
    UIButton *lastButton = nil;
    for (NSString *key in colorList) {
        UIButton *colorButton = [UIButton new];
        
        int line = (colorIndex-1)/5 + 1;
        
        NSString *colorString = [colorList objectForKey:key];
        
        unsigned long colorValue = strtoul([colorString UTF8String],0,16);
        
        [colorButton setBackgroundColor:UIColorFromRGB(colorValue)];
        
        [colorButton addTarget:self action:@selector(choosePackageType:) forControlEvents:UIControlEventTouchUpInside];
        
        [colorButton setTag:[key intValue]];
        
        [packageView addSubview:colorButton];
        
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
            make.top.equalTo(txtValue.mas_bottom).with.offset(marginTop);
            make.left.equalTo(packageView).with.offset(marginLeft);
        }];
        
        lastButton = colorButton;
        
        colorIndex++;
    }
    /*-------end------*/
    
    addButton = [UIButton new];
    addButton.layer.cornerRadius =5.0;
    [addButton setTitle:NSLocalizedString(@"packageViewController_002", nil) forState:UIControlStateNormal];
    [addButton setBackgroundColor:UIColorFromRGB(color_blue_01)];
    [addButton addTarget:self action:@selector(savePackage:) forControlEvents:UIControlEventTouchUpInside];
    [packageView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastButton.mas_bottom).with.offset(5);
        make.left.equalTo(packageView).with.offset(5);
        make.right.equalTo(packageView.mas_right).with.offset(-5);
        make.height.equalTo(@35);
    }];
    
    [packageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(addButton.mas_bottom).with.offset(5);
        make.width.mas_equalTo(ScreenSize.width*2/3);
        make.left.mas_equalTo(ScreenSize.width/6);
        make.top.equalTo(self.view).with.offset(-50);
    }];
    /*--------end--------*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    selectedButton = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
    //add event
    UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addAction:)];
    addTap.delegate=self;
    addTap.numberOfTapsRequired = 1;
    addView.userInteractionEnabled=YES;
    [addView addGestureRecognizer:addTap];
    
    UITapGestureRecognizer *transferTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editAction:)];
    transferTap.delegate=self;
    transferTap.numberOfTapsRequired = 1;
    transferButton.userInteractionEnabled=YES;
    [transferButton addGestureRecognizer:transferTap];
    tabelViewSource = [self loadData];
    
    [tabelList reloadData];
    /*-------观察者模式，监控屏幕手势触摸------*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScreenTouch:) name:[MonitorApplication getNotificationObserKey] object:nil];
    
    /*--------添加要取消的输入框集合--------*/
    [self addTextFieldArray:txtPackName];
    [self addTextFieldArray:txtValue];
    /*--------end--------*/
}

#pragma mark---load data

-(NSMutableArray*)loadData{
    NSMutableArray *array = [[PackageDAL Instance] getPackageCompare];
    return array;
}

#pragma mark---UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tabelViewSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PackageTableViewCell *cell = [PackageTableViewCell cellWithTableView:tableView indexpath:indexPath];
    PackageCompare *package = [tabelViewSource objectAtIndex:indexPath.item];
    NSString *colorString = [colorList objectForKey:package.PCOLOR];
    unsigned long color = strtoul([colorString UTF8String],0,16);
    [cell setPointColor:color];
    [cell setTitle:package.PNAME];
    [cell setRightValue:[NSString stringWithFormat:@"%.1f",package.PVALUE]];
    [cell setEditAction:^(NSInteger item) {
        DDLogDebug(@"你选择了%ld",(long)item);
        PackageCompare *model = [tabelViewSource objectAtIndex:item];
        PackageEditViewController *editViewController = [[PackageEditViewController alloc] initWithProperty:NO cm:model];
        [self.navigationController pushViewController:editViewController animated:YES];
    }];
    [cell setDeleteAction:^(NSInteger item,PackageTableViewCell *row) {
        DDLogDebug(@"你删除了%ld",(long)item);
        [DLZAlertView showAlertMessage:self.tabBarController title:NSLocalizedString(@"common_warning", nil) content:NSLocalizedString(@"common_confirmdelete", nil) leftButton:NSLocalizedString(@"common_cancel", nil) leftaction:^(id sender) {
            DLZAlertView *view = sender;
            [view removeFromSuperview];
        } rightButton:NSLocalizedString(@"common_confirm", nil) rightaction:^(id sender) {
            PackageCompare *model = [tabelViewSource objectAtIndex:item];
            BOOL state = [[PackageDAL Instance] deletePackage:model.PID];
            if (state) {
                [tabelViewSource removeObjectAtIndex:item];
                [tableView reloadData];
            }else{
                [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_failed", nil)];
            }
            DLZAlertView *view = sender;
            [view removeFromSuperview];
        }];
    }];
    [cell setMoveComplete:^(PackageTableViewCell *cl) {
        editCell = cl;
        isEdit = YES;
        tabelList.scrollEnabled = NO;
    }];
    [cell setResetComplete:^(PackageTableViewCell *cl) {
        isEdit = NO;
        tabelList.scrollEnabled = YES;
    }];
    return cell;
}

//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
////    if (editingStyle==UITableViewCellEditingStyleDelete) {
//////        [tabelViewSource removeObjectAtIndex:indexPath.row];
////        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
////    }
//}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return UITableViewCellEditingStyleNone;
    //    return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    PackageCompare *sp = [tabelViewSource objectAtIndex:sourceIndexPath.row];
    PackageCompare *tp = [tabelViewSource objectAtIndex:destinationIndexPath.row];
    if (sourceIndexPath.row!=destinationIndexPath.row) {
        sp.PSORT = destinationIndexPath.row;
        tp.PSORT = sourceIndexPath.row;
        [[PackageDAL Instance] sortPackage:sp p2:tp];
    }
}

//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
//        
//    }];//此处是iOS8.0以后苹果最新推出的api，UITableViewRowAction，Style是划出的标签颜色等状态的定义，这里也可自行定义
//
//    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//    }];
//    deleteRoWAction.backgroundColor=[UIColor whiteColor];
//    editRowAction.backgroundColor = [UIColor whiteColor];//可以定义RowAction的颜色
//    return @[deleteRoWAction, editRowAction];//最后返回这俩个RowAction 的数组
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark---Combox selected changed
-(void)DLZCombox:(UIView *)combox didSelectedItemAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            
        }
            break;
            
        default:
            break;
    }
}
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
    packageType = [selectedButton tag];
}
/*
 *--------------保存钱包----------------*
 */
-(void)savePackage:(id)sender{
    packageName = [txtPackName text];
    packageValue = [[txtValue text] doubleValue];
    self.hub = [[AlertController sharedInstance] showMessage:self.view message:NSLocalizedString(@"common_saving", nil)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        PackageCompare *model = [[PackageDAL Instance] addPackage:packageName pvalue:packageValue pcolor:[NSString stringWithFormat:@"%d",packageType]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (model!=nil) {
                packageView.isShow=NO;
                [self touchesEnded:nil withEvent:nil];
                [[AlertController sharedInstance] closeMessage:self.hub];
                
                [tabelViewSource addObject:model];
                [tabelList reloadData];
                
            }else{
                [[AlertController sharedInstance] closeMessage:self.hub];
                [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savefailed", nil)];
            }
        });
        
    });
}

#pragma mark---协议事件
-(void)addAction:(UIGestureRecognizer*)sender{
    if (packageView.isShow && packageView.alpha==1.0) {
        return;
    }
//    packageView.alpha = 1.0f;
    packageView.isShow=YES;
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = 0.2; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.autoreverses = NO; // 动画结束时执行逆动画
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion=NO;
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    
    // 添加动画
    [packageView.layer addAnimation:animation forKey:@"scale-layer"];
}

#pragma mark---转账
-(void)editAction:(UIGestureRecognizer*)sender{
//    [tabelList setEditing:YES];
    TransferViewController *transferController = [[TransferViewController alloc] init];
    [self.navigationController pushViewController:transferController animated:YES];
}

#pragma mark---touch事件响应链
-(void)onScreenTouch:(NSNotification *)notification{
    
    BOOL isshow = [((AppDelegate *)[self getAppdelegate]) iskeyboardShow];
    
    if (isshow) {
        return;
    }
    
    UIEvent *event = [notification.userInfo objectForKey:@"data"];
    UITouch *touch = [event.allTouches anyObject];
    
    if (!packageView.isShow) {
        if ([touch.view isKindOfClass:[DLZAlertView class]] || [touch.view.superview isKindOfClass:[DLZAlertView class]] || [touch.view.superview.superview isKindOfClass:[DLZAlertView class]]) {
            return;
        }
        
        CGPoint tapPoint = [touch locationInView:tabelList];
        if (tapPoint.y>0) {
            if (![touch.view isKindOfClass:[UIButton class]]) {
                [editCell scrollToZero];
            }
        }
    }

    if (touch.view==addView || touch.view == packageView || touch.view.superview == packageView) {
        return;
    }
    if (touch.view!=packageView) {
        if (packageView.isShow) {
//            packageView.alpha=0.0;
            packageView.isShow=NO;
        }
    }
}

#pragma mark---观察者响应事件
/*
 *--------------添加监视对象----------------*
 */
-(void)addObservObject{
    if ([self fbkvo]!=nil) {
        [[self fbkvo]
         observe:packageView keyPath:@"isShow" options:NSKeyValueObservingOptionNew block:^(id observer,id object,NSDictionary *change)
         {
             BOOL r = [change[NSKeyValueChangeNewKey] boolValue];
             if (r) {
                 packageView.alpha = 1.0;
             }else{
                 packageView.alpha = 0.0;
                 [txtPackName setText:@""];
                 [txtValue setText:@""];
//                 if (selectedButton!=nil) {
//                     selectedButton.alpha = 1.0;
//                     selectedButton = nil;
//                 }
             }
         }];
    }
}

@end
