//
//  DetailTableViewCell.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/4.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell{
    UILabel *leftValue;
    UILabel *rightValue;
    UILabel *leftMark;
    UILabel *rightMark;
    UIView *centerView;
    UILabel *centerLabel;
    
    UIView *topView;
    UIView *bottomView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)setLeftvalue:(NSString*)v;

-(void)setLeftColor:(UIColor *)color;

-(void)setLeftMark:(NSString*)v;

-(void)setLeftMarkColor:(UIColor *)color;

-(void)setRightvalue:(NSString*)v;

-(void)setRightColor:(UIColor *)color;

-(void)setRightMark:(NSString*)v;

-(void)setRightMarkColor:(UIColor *)color;

-(void)setCenterColor:(long)color;

-(void)hiddenBottom;

-(void)showDeleteButton:(UIView *)view;
-(void)hiddenDeleteButton;
@end
