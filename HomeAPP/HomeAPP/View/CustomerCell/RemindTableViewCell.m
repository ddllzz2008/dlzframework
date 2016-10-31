//
//  RemindTableViewCell.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/25.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "RemindTableViewCell.h"

@implementation RemindTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath*)indexpath{
    static NSString *identifier = @"RemindTableViewCell";
    
    RemindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[RemindTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexpath:indexpath];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexpath:(NSIndexPath*)indexpath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGSize size = self.contentView.frame.size;
        
        UIView *headerView = [UIView new];
        headerView.backgroundColor = UIColorFromRGB(color_blue_01);
        [self.contentView addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(self.contentView);
        }];
        
        leftLabel = [UILabel new];
        [leftLabel styleForNormal];
        leftLabel.textAlignment=NSTextAlignmentLeft;
        [headerView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerView).with.offset(5);
            make.centerY.equalTo(headerView);
            make.right.equalTo(headerView.mas_right).with.offset(-70);
        }];
        
        UISwitch *sch = [UISwitch new];
        sch.on=YES;
//        sch.backgroundColor=UIColorFromRGB(color_red_01);
        [headerView addSubview:sch];
        [sch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView.mas_right).with.offset(-5);
            make.width.equalTo(@60);
            make.height.equalTo(@30);
            make.centerY.equalTo(headerView);
        }];
        
        messageLabel = [UILabel new];
        [messageLabel styleForNormalBlack];
        messageLabel.textAlignment=NSTextAlignmentLeft;
        messageLabel.lineBreakMode=NSLineBreakByWordWrapping;
        messageLabel.numberOfLines = 0;
        [self.contentView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.mas_bottom).with.offset(5);
            make.left.equalTo(self.contentView).with.offset(5);
            make.width.mas_equalTo(size.width-10);
            make.height.equalTo(@50);
        }];
    }
    
    return self;
}

-(void)setTimeValue:(NSString*)time{
    [leftLabel setText:time];
}

-(void)setMessageValue:(NSString*)message{
    [messageLabel setText:message];
}

@end
