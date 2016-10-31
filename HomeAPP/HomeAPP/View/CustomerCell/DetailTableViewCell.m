//
//  DetailTableViewCell.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/4.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"PackageTableViewCell";
    
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = self.contentView.frame.size;
        
        centerView = [UIView new];
        centerView.layer.cornerRadius = 15;
        centerView.clipsToBounds=YES;
        [self.contentView addSubview:centerView];
        [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(30,30));
        }];
        
        leftValue = [UILabel new];
        leftValue.textAlignment=NSTextAlignmentRight;
        [leftValue styleForSmallBlack];
        [self.contentView addSubview:leftValue];
        [leftValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(centerView.mas_left).with.offset(-3);
            make.centerY.equalTo(self.contentView).with.offset(-2);
            make.size.mas_equalTo(CGSizeMake((size.width-50)/2, size.height/2));
        }];
        
        leftMark = [UILabel new];
        leftMark.textAlignment=NSTextAlignmentRight;
        [leftMark styleForSmallBlack];
        [self.contentView addSubview:leftMark];
        [leftMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((size.width-50)/2, size.height/2));
            make.left.equalTo(self.contentView).with.offset(0);
            make.top.equalTo(leftValue.mas_bottom).with.offset(2);
        }];
        
        rightValue = [UILabel new];
        rightValue.textAlignment=NSTextAlignmentLeft;
        [rightValue styleForSmallBlack];
        [self.contentView addSubview:rightValue];
        [rightValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(centerView.mas_right).with.offset(3);
            make.centerY.equalTo(self.contentView).with.offset(-2);
            make.size.mas_equalTo(CGSizeMake((size.width-50)/2, size.height/2));
        }];
        
        rightMark = [UILabel new];
        rightMark.textAlignment=NSTextAlignmentLeft;
        [rightMark styleForSmallBlack];
        [self.contentView addSubview:rightMark];
        [rightMark mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((size.width-50)/2, size.height/2));
            make.left.equalTo(centerView.mas_right).with.offset(0);
            make.top.equalTo(rightValue.mas_bottom).with.offset(2);
        }];
        
        //画连接线
        topView = [UIView new];
        [topView setBackgroundColor:UIColorFromRGB(color_gray_01)];
        [self.contentView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).with.offset(0);
            make.bottom.equalTo(centerView.mas_top).with.offset(0);
        }];
        
        bottomView = [UIView new];
        [bottomView setBackgroundColor:UIColorFromRGB(color_gray_01)];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@1);
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(centerView.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark---修改表格属性
-(void)setLeftvalue:(NSString*)v{
    [leftValue setText:v];
}

-(void)setLeftColor:(UIColor *)color{
    [leftValue setTextColor:color];
}

-(void)setLeftMark:(NSString*)v{
    [leftMark setText:v];
}

-(void)setLeftMarkColor:(UIColor *)color{
    [leftMark setTextColor:color];
}

-(void)setRightvalue:(NSString*)v{
    [rightValue setText:v];
}

-(void)setRightColor:(UIColor *)color{
    [rightValue setTextColor:color];
}

-(void)setRightMark:(NSString*)v{
    [rightMark setText:v];
}

-(void)setRightMarkColor:(UIColor *)color{
    [rightMark setTextColor:color];
}

-(void)setCenterColor:(long)color{
    [centerView setBackgroundColor:UIColorFromRGB(color)];
}

-(void)hiddenBottom{
    bottomView.alpha = 0.0;
}

#pragma mark---删除模式
-(void)showDeleteButton:(UIView *)view{
    [centerView addSubview:view];
}
-(void)hiddenDeleteButton{
    if (centerView.subviews.count>0) {
        [centerView.subviews[0] removeFromSuperview];
    }
}

@end
