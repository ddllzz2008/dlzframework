//
//  SpendCollectionViewCell.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/28.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "SpendCollectionViewCell.h"

@implementation SpendCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellView = [UIView new];
        self.cellView.layer.cornerRadius = 40;
        self.cellView.backgroundColor = UIColorFromRGB(color_gray_01);
        [self.contentView addSubview:self.cellView];
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.center.equalTo(self.contentView);
        }];
        
        self.titleLabel = [UILabel new];
        [self.titleLabel styleForContent];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.cellView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 20));
            make.centerX.equalTo(self.cellView);
            make.top.equalTo(self.cellView).with.offset(15);
        }];
        
        self.valueLabel = [UILabel new];
        [self.valueLabel styleForContent];
        self.valueLabel.textAlignment=NSTextAlignmentCenter;
        [self.cellView addSubview:self.valueLabel];
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 20));
            make.centerX.equalTo(self.cellView);
            make.bottom.equalTo(self.cellView).with.offset(-15);
        }];
    }
    return self;
}

-(void)setSpendText:(NSString*)text{
    [self.titleLabel setText:text];
}

-(void)setSpendValue:(NSString*)svalue{
    [self.valueLabel setText:svalue];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [self.cellView setBackgroundColor:backgroundColor];
}

@end
