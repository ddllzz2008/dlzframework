//
//  SpendCollectionViewCell.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpendCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong,readwrite) UIView *cellView;

@property (nonatomic,strong,readwrite) UILabel *titleLabel;

@property (nonatomic,strong,readwrite) UILabel *valueLabel;

-(void)setSpendText:(NSString*)text;

-(void)setSpendValue:(NSString*)svalue;

-(void)setBackgroundColor:(UIColor *)backgroundColor;

@end
