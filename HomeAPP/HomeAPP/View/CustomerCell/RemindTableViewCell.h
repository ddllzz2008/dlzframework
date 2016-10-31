//
//  RemindTableViewCell.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/25.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindTableViewCell : UITableViewCell{
    __strong UILabel *leftLabel;
    __strong UILabel *messageLabel;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath*)indexpath;

-(void)setTimeValue:(NSString*)time;

-(void)setMessageValue:(NSString*)message;

@end
