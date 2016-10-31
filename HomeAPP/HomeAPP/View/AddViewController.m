//
//  AddViewController.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/14.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController (){
    NSDate *model_choosedate;
    NSString *model_categoryID;
    NSString *model_packageID;
    
    NSDictionary *colorList;
    
    //soure
    NSMutableArray *typeSource;
    NSMutableArray *packageSource;
    
    UIImageView *imgView;
    CategoryModel *typemodel;
    PackageCompare *packagemodel;
}

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
 *----------------------初始化控件-------------------------------*
 */
-(void)initControls{
    /*--------头部--------*/
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
    
    backView = [UIImageView new];
    [backView setImage:[UIImage imageNamed:@"back_blue-Small"]];
    [headerView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(29, 29));
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).with.offset(10);
    }];
    
    NSArray *segmentSource = [NSArray arrayWithObjects:@"收入",@"支出", nil];
    segmentView = [[UISegmentedControl alloc] initWithItems:segmentSource];
    segmentView.segmentedControlStyle=UISegmentedControlStyleBar;
    segmentView.momentary=NO;
    segmentView.tintColor=UIColorFromRGB(color_blue_01);
    [segmentView setSelectedSegmentIndex:1];
    [headerView addSubview:segmentView];
    [segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width-150, 30));
    }];
    
    UIButton *confirmBtn = [UIButton new];
    [confirmBtn setTitle:NSLocalizedString(@"common_confirm", nil) forState:UIControlStateNormal];
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
    
    UIView *spendView = [UIView new];
    spendView.backgroundColor = UIColorFromRGB(color_blue_01);
    [self.view addSubview:spendView];
    [spendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
        make.top.equalTo(headerView.mas_bottom).with.offset(10);
    }];
    
    UILabel *spendTitle = [UILabel new];
    [spendTitle setText:NSLocalizedString(@"addviewcontroller_001", nil)];
    [spendTitle styleForNormal];
    CGSize spendTitleSize = [spendTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    spendTitleSize = CGSizeMake(spendTitleSize.width+10, spendTitleSize.height);
    [spendView addSubview:spendTitle];
    [spendTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(spendView);
        make.left.equalTo(spendView).with.offset(10);
        make.size.mas_equalTo(spendTitleSize);
    }];
    
    spendAccount = [UITextField new];
    [spendAccount setBackgroundColor:UIColorFromRGB(color_white_01)];
    spendAccount.textAlignment=NSTextAlignmentRight;
    spendAccount.keyboardType=UIKeyboardTypeDecimalPad;
    spendAccount.returnKeyType=UIReturnKeyDone;
    [spendAccount setPlaceholder:NSLocalizedString(@"addviewcontroller_008", nil)];
    [spendView addSubview:spendAccount];
    [spendAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(spendTitle.mas_right).with.offset(5);
        make.right.equalTo(spendView.mas_right).with.offset(-5);
        make.centerY.equalTo(spendView);
        make.height.equalTo(@30);
    }];
    
    /*--------所在位置行--------*/
    UIView *locationView = [UIView new];
    [locationView setBackgroundColor:UIColorFromRGB(color_gray_02)];
    [self.view addSubview:locationView];
    [locationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(spendView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    UILabel *locationTitle = [UILabel new];
    locationTitle.textAlignment=NSTextAlignmentLeft;
    [locationTitle setText:NSLocalizedString(@"addviewcontroller_002", nil)];
    [locationTitle styleForNormal];
    CGSize locationSize = [locationTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    [locationView addSubview:locationTitle];
    [locationTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationView);
        make.left.equalTo(locationView).with.offset(10);
        make.size.mas_equalTo(locationSize);
    }];
    
    UILabel *responseTitle = [UILabel new];
    responseTitle.textAlignment=NSTextAlignmentRight;
    [responseTitle setText:NSLocalizedString(@"addviewcontroller_003", nil)];
    [responseTitle styleForNormal];
    CGSize responseSize = [responseTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    responseSize = CGSizeMake(responseSize.width+10, responseSize.height);
    [locationView addSubview:responseTitle];
    [responseTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(locationView);
        make.right.equalTo(locationView).with.offset(-10);
        make.size.mas_equalTo(responseSize);
    }];
    /*--------end--------*/
    /*--------日期选择行--------*/
    dateView = [UIView new];
    [dateView setBackgroundColor:UIColorFromRGB(color_gray_02)];
    [self.view addSubview:dateView];
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(locationView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    UILabel *dateTitle = [UILabel new];
    dateTitle.textAlignment=NSTextAlignmentLeft;
    [dateTitle setText:NSLocalizedString(@"addviewcontroller_004", nil)];
    [dateTitle styleForNormal];
    CGSize dateSize = [locationTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    [dateView addSubview:dateTitle];
    [dateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateView);
        make.left.equalTo(dateView).with.offset(10);
        make.size.mas_equalTo(locationSize);
    }];
    
    dateSelected = [UILabel new];
    dateSelected.textAlignment=NSTextAlignmentRight;
    [dateSelected setText:NSLocalizedString(@"addviewcontroller_005", nil)];
    [dateSelected styleForNormal];
    dateSize = [responseTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    dateSize = CGSizeMake(dateSize.width+10, dateSize.height);
    [dateView addSubview:dateSelected];
    [dateSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateView);
        make.right.equalTo(dateView).with.offset(-10);
        make.size.mas_equalTo(dateSize);
    }];
    /*--------end--------*/
    /*--------类型选择行--------*/
    UIView *categorySelectedView = [UIView new];
    [categorySelectedView setBackgroundColor:UIColorFromRGB(color_gray_02)];
    [self.view addSubview:categorySelectedView];
    [categorySelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    NSArray *typeArray = [NSArray arrayWithObjects:@"类型",@"钱包", nil];
    segmentType = [[UISegmentedControl alloc] initWithItems:typeArray];
    segmentType.segmentedControlStyle=UISegmentedControlStyleBar;
    segmentType.momentary=NO;
    segmentType.tintColor=UIColorFromRGB(color_blue_01);
    [segmentType setSelectedSegmentIndex:0];
    [categorySelectedView addSubview:segmentType];
    [segmentType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(categorySelectedView);
        make.left.equalTo(categorySelectedView).with.offset(10);
        make.width.equalTo(@140);
    }];
    
    categorySelected = [UILabel new];
    categorySelected.textAlignment=NSTextAlignmentRight;
    [categorySelected setText:NSLocalizedString(@"addviewcontroller_006", nil)];
    [categorySelected styleForNormal];
    dateSize = [categorySelected getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    dateSize = CGSizeMake(dateSize.width+10, dateSize.height);
    [categorySelectedView addSubview:categorySelected];
    [categorySelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(categorySelectedView);
        make.right.equalTo(categorySelectedView).with.offset(-10);
        make.size.mas_equalTo(dateSize);
    }];
    
    packageSelected = [UILabel new];
    packageSelected.alpha = 0.0;
    packageSelected.textAlignment=NSTextAlignmentRight;
    [packageSelected setText:NSLocalizedString(@"addviewcontroller_009", nil)];
    [packageSelected styleForNormal];
    dateSize = [packageSelected getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    dateSize = CGSizeMake(dateSize.width+10, dateSize.height);
    [categorySelectedView addSubview:packageSelected];
    [packageSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(categorySelectedView);
        make.right.equalTo(categorySelectedView).with.offset(-10);
        make.size.mas_equalTo(dateSize);
    }];
    /*--------end--------*/
    /*--------选择类型--------*/
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.itemSize=CGSizeMake(ScreenSize.width/3-10, 50);
    flowLayout.minimumInteritemSpacing=0;
    categoryView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    categoryView.dataSource=self;
    categoryView.delegate=self;
    categoryView.bounces=NO;
    categoryView.backgroundColor=[UIColor clearColor];
    categoryView.alwaysBounceVertical=YES;
    categoryView.showsHorizontalScrollIndicator=NO;
    [categoryView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
    [self.view addSubview:categoryView];
    [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(categorySelectedView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-54);
        make.width.equalTo(self.view);
    }];
    /*--------end--------*/
    /*----------添加备注----------*/
    UIView *markView = [UIView new];
    [markView setBackgroundColor:UIColorFromRGB(color_blue_01)];
    [self.view addSubview:markView];
    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 44));
    }];
    
    UILabel *markTitle = [UILabel new];
    markTitle.textAlignment=NSTextAlignmentLeft;
    [markTitle setText:NSLocalizedString(@"addviewcontroller_010", nil)];
    [markTitle styleForNormal];
    dateSize = [locationTitle getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    [markView addSubview:markTitle];
    [markTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(markView);
        make.left.equalTo(markView).with.offset(10);
        make.size.mas_equalTo(dateSize);
    }];
    markText = [UITextField new];
    [markText setBackgroundColor:UIColorFromRGB(color_white_01)];
    markText.textAlignment=NSTextAlignmentRight;
    markText.keyboardType=UIKeyboardTypeDefault;
    markText.returnKeyType=UIReturnKeyDone;
    [markText setPlaceholder:NSLocalizedString(@"addviewcontroller_011", nil)];
    [markView addSubview:markText];
    [markText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(markTitle.mas_right).with.offset(5);
        make.right.equalTo(markView.mas_right).with.offset(-5);
        make.centerY.equalTo(markView);
        make.height.equalTo(@30);
    }];
    /*--------end--------*/
    /*--------添加要取消的输入框集合--------*/
    [self addTextFieldArray:spendAccount];
    [self addTextFieldArray:markText];
    /*--------end--------*/
}
-(void)viewWillAppear:(BOOL)animated{
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDate:)];
    dateTap.delegate=self;
    dateSelected.userInteractionEnabled=YES;
    [dateSelected addGestureRecognizer:dateTap];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    backTap.delegate=self;
    backView.userInteractionEnabled=YES;
    [backView addGestureRecognizer:backTap];
    
    //收入或支出切换
    [segmentView addTarget:self action:@selector(ioeChanged:) forControlEvents:UIControlEventValueChanged];
    
    [segmentType addTarget:self action:@selector(typeChanged:) forControlEvents:UIControlEventValueChanged];
    
    /*-------读取颜色列表------*/
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ArgumentArray" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    colorList = [data objectForKey:@"ColorList"];
    //load data
    if (segmentView.selectedSegmentIndex == 0) {
        typeSource = [[CategoryDAL Instance] getCategory:1];
    }else{
        typeSource = [[CategoryDAL Instance] getCategory:0];
    }
    [typeSource addObject:[NSNull null]];
    
    packageSource = [[PackageDAL Instance] getPackageCompare];
    
    ((AppDelegate *)[self getAppdelegate]).keyboardDelegate=self;
    
    [categoryView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    ((AppDelegate *)[self getAppdelegate]).keyboardDelegate=nil;
}

#pragma mark----event method
-(void)chooseDate:(id)sender{
    [DLZDatePicker showActionDateSheet:self.view date:nil chooseCallBack:^(NSArray *resultArray) {
        model_choosedate = [resultArray objectAtIndex:0];
        [dateSelected setText:[resultArray objectAtIndex:1]];
    }];
}
#pragma mark---页面返回
-(void)backAction:(UITapGestureRecognizer*)sender{
    [self resetView];
    [self.tabBarController setSelectedIndex:((AppDelegate *)[self getAppdelegate]).lastTabbarIndex];
}

#pragma mark---类型切换
-(void)typeChanged:(UISegmentedControl *)Seg{
    if (Seg.selectedSegmentIndex==0) {
        categorySelected.alpha = 1.0;
        packageSelected.alpha = 0.0;
    }else{
        categorySelected.alpha = 0.0;
        packageSelected.alpha = 1.0;
    }
    [categoryView reloadData];
}

#pragma mark---收入支出切换
-(void)ioeChanged:(UISegmentedControl *)Seg{
    if (Seg.selectedSegmentIndex==0) {
        [spendAccount setPlaceholder:NSLocalizedString(@"addviewcontroller_012", nil)];
        typeSource = [[CategoryDAL Instance] getCategory:1];
        [typeSource addObject:[NSNull null]];
    }else{
        [spendAccount setPlaceholder:NSLocalizedString(@"addviewcontroller_008", nil)];
        typeSource = [[CategoryDAL Instance] getCategory:0];
        [typeSource addObject:[NSNull null]];
    }
    model_categoryID = nil;
    model_packageID = nil;
    [packageSelected setText:NSLocalizedString(@"addviewcontroller_009", nil)];
    [categorySelected setText:NSLocalizedString(@"addviewcontroller_006", nil)];
    
    [categoryView reloadData];
}

#pragma mark----uicollectionview protocol
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (segmentType.selectedSegmentIndex == 0) {
        return typeSource.count;
    }else{
        return packageSource.count;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *indentifier = @"CategoryCollectionViewCell";
    
    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    
    if (segmentType.selectedSegmentIndex == 0) {
        
        id m = [typeSource objectAtIndex:indexPath.row];
        
        if ([m isEqual:[NSNull null]]) {
            [cell showAddImage];
            [cell setBackgroundColor:UIColorFromRGB(color_blue_01)];
        }
        else{
            CategoryModel *cmodel = (CategoryModel *)m;
            [cell setTitle:cmodel.CNAME];
            NSString *colorString = [colorList objectForKey:cmodel.CCOLOR];
            if (colorString == nil || [colorString isBlankString]) {
                [cell setBackgroundColor:UIColorFromRGB(color_blue_01)];
            }else{
                unsigned long color = strtoul([colorString UTF8String],0,16);
                [cell setBackgroundColor:UIColorFromRGB(color)];
            }
        }
    }else{
        PackageCompare *pmodel = [packageSource objectAtIndex:indexPath.row];
        [cell setTitle:pmodel.PNAME];
        NSString *colorString = [colorList objectForKey:pmodel.PCOLOR];
        if (colorString == nil || [colorString isBlankString]) {
            [cell setBackgroundColor:UIColorFromRGB(color_blue_01)];
        }else{
            unsigned long color = strtoul([colorString UTF8String],0,16);
            [cell setBackgroundColor:UIColorFromRGB(color)];
        }
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoryCollectionViewCell *cell = (CategoryCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (segmentType.selectedSegmentIndex == 0) {
        if (indexPath.item == typeSource.count - 1) {
            NSInteger typeID = segmentView.selectedSegmentIndex==0?1:0;
            MdyCategoryViewController *mdyController = [[MdyCategoryViewController alloc] initWithProperty:YES ioe:typeID cm:nil];
            mdyController.argumentDelegate = self;
            [self.navigationController pushViewController:mdyController animated:YES];
            return;
        }
        typemodel = [typeSource objectAtIndex:indexPath.item];
        model_categoryID = typemodel.CID;
    }else{
        packagemodel = [packageSource objectAtIndex:indexPath.item];
        model_packageID = packagemodel.PID;
    }
    
    //获取图像
    UIImage *image = [cell snapshot];
    
    CGFloat bit = cell.bounds.size.width/cell.bounds.size.height;
    
    CGFloat width = cell.bounds.size.width-30;
    
    CGFloat height = width/bit;
    
    CGPoint originInSuperview = [self.view convertPoint:CGPointZero fromView:cell];
    
    CGFloat px = originInSuperview.x+15;
    CGFloat py = originInSuperview.y+(15/bit);
    
    CGRect rect = CGRectMake(px, py, width, height);
    
    imgView = [[UIImageView alloc] initWithFrame:rect];
    [imgView setImage:image];
    imgView.alpha=0.8;
    [self.view addSubview:imgView];
    
    CGPoint endPoint = [self.view convertPoint:CGPointZero fromView:categorySelected];
    endPoint = CGPointMake(ScreenSize.width-width-10, endPoint.y);
    //定义动画变量
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    bounceAnimation.delegate=self;
    //然后设置一个路径
    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, px+(width/2), py+(height/2));
    CGPathAddQuadCurveToPoint(thePath, NULL, 150, 30, endPoint.x, endPoint.y);
    bounceAnimation.path = thePath;
    bounceAnimation.duration = 0.7;
    [imgView.layer addAnimation:bounceAnimation forKey:@"move"];
}

NSInteger itemNumber;
CGFloat itemHeight;
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    itemNumber = categoryView.bounds.size.height/50;
    itemHeight = (categoryView.bounds.size.height - (itemNumber-1) * 5)/itemNumber;
    return CGSizeMake(ScreenSize.width/3-10, itemHeight);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark---animation stopped
/*
 *--------------动画结束----------------*
 */
-(void)animationDidStart:(CAAnimation *)anim{
    [self.view setUserInteractionEnabled:NO];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [imgView removeFromSuperview];
        if (segmentType.selectedSegmentIndex == 0){
            [categorySelected setText:typemodel.CNAME];
        }
        else{
            [packageSelected setText:packagemodel.PNAME];
        }
    }
    [self.view setUserInteractionEnabled:YES];
}

#pragma mark---save logic
-(void)saveAction:(id)sender{
    self.hub = [[AlertController sharedInstance] showMessage:self.view message:NSLocalizedString(@"common_saving", nil)];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *datas = [[StoreUserDefault instance] getDataWithNSData:datastore_familyArray];
        NSArray *persons = [NSKeyedUnarchiver unarchiveObjectWithData:datas];
        FamilyPerson *person = (FamilyPerson*)[persons objectAtIndex:0];
        if (person!=nil) {
            BOOL result = YES;
            if (segmentView.selectedSegmentIndex==1) {
                result = [[ExpenditureDAL Instance] addExpenditure:[CommonFunc NewGUID] evalue:[spendAccount.text doubleValue] cid:model_categoryID fid:person.fid pid:model_packageID createtime:[[NSDate date] formatWithCode:dateformat_07] eyear:[model_choosedate formatWithCode:dateformat_04] emonth:[model_choosedate formatWithCode:dateformat_05] eday:[model_choosedate formatWithCode:dateformat_06] imark:markText.text];
            }else{
                result = [[IncomeDAL Instance] addIncome:[CommonFunc NewGUID] evalue:[spendAccount.text doubleValue] cid:model_categoryID fid:person.fid pid:model_packageID createtime:[[NSDate date] formatWithCode:dateformat_07] eyear:[model_choosedate formatWithCode:dateformat_04] emonth:[model_choosedate formatWithCode:dateformat_05] eday:[model_choosedate formatWithCode:dateformat_06] imark:markText.text];
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    [[AlertController sharedInstance] closeMessage:self.hub];
                    [self resetView];
                    [self.tabBarController setSelectedIndex:((AppDelegate *)[self getAppdelegate]).lastTabbarIndex];
                }else{
                    [[AlertController sharedInstance] closeMessage:self.hub];
                    [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savefailed", nil)];
                }
            });
        }else{
            [[AlertController sharedInstance] closeMessage:self.hub];
            [[AlertController sharedInstance] showMessageAutoClose:self.view message:NSLocalizedString(@"common_savefailed", nil)];
        }
    });
}

#pragma mark---键盘打开和隐藏协议
-(void)keyboardStateChanged:(BOOL)ishow view:(UIView *)view rect:(CGRect)rect{
    if (view!=nil) {
        if (ishow) {
            UIView *superView = [view superview];
            CGPoint originSuper = [self.view convertPoint:CGPointZero fromView:superView];
            if (rect.size.height + originSuper.y + superView.bounds.size.height > ScreenSize.height) {
                self.view.frame=CGRectMake(0,0 - rect.size.height, self.view.frame.size.width, self.view.frame.size.height);
            }
        }else{
            if (view==markText) {
                self.view.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
            }
        }
    }
}

#pragma mark---还原页面数据
-(void)resetView{
    [spendAccount setText:@""];
    [dateSelected setText:NSLocalizedString(@"addviewcontroller_005", nil)];
    [markText setText:@""];
    
    segmentType.selectedSegmentIndex = 0;
    segmentView.selectedSegmentIndex= 1;
    
    [categorySelected setText:NSLocalizedString(@"addviewcontroller_006", nil)];
    [packageSelected setText:NSLocalizedString(@"addviewcontroller_009", nil)];
    
    model_choosedate = nil;
    model_categoryID = nil;
    model_packageID= nil;
}

#pragma mark---观察者响应事件
-(void)updateWidth:(UILabel *)label{
    CGSize dateSize = [label getLabelSize:CGSizeMake(ScreenSize.width/2, 44)];
    dateSize = CGSizeMake(dateSize.width+10, dateSize.height);
    [label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(dateSize);
    }];
}
/*
 *--------------添加监视对象----------------*
 */
-(void)addObservObject{
    if ([self fbkvo]!=nil) {
        [[self fbkvo]
         observe:dateSelected keyPath:@"text" options:NSKeyValueObservingOptionNew block:^(id observer,id object,NSDictionary *change)
         {
             [self updateWidth:dateSelected];
         }];
        
        [[self fbkvo]
         observe:categorySelected keyPath:@"text" options:NSKeyValueObservingOptionNew block:^(id observer,id object,NSDictionary *change)
         {
             [self updateWidth:dateSelected];
         }];
        
        [[self fbkvo]
         observe:packageSelected keyPath:@"text" options:NSKeyValueObservingOptionNew block:^(id observer,id object,NSDictionary *change)
         {
             [self updateWidth:dateSelected];
         }];
    }
}

#pragma mark---接受添加类别页面回调的协议
-(void)receiveDataFromViewController:(UIViewController *)controller argument:(id)argument{
//    if (controller!=nil) {
//        CategoryModel *categoryModel = argument;
//        if (categoryModel!=nil) {
//            if (typeSource!=nil) {
//                [typeSource insertObject:categoryModel atIndex:(typeSource.count -1)];
//                [categoryView reloadData];
//            }
//        }
//    }
}
@end
