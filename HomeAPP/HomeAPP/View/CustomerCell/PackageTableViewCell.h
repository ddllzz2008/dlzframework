//
//  PackageTableViewCell.h
//  HomeAPP
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawLineView.h"

@interface PackageTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (copy) void(^editAction)(NSInteger);
@property (copy) void(^deleteAction)(NSInteger,PackageTableViewCell*);
@property (copy) void(^moveComplete)(PackageTableViewCell*);
@property (copy) void(^resetComplete)(PackageTableViewCell*);

+ (instancetype)cellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath*)indexpath;

-(void)setPointColor:(long)color;

-(void)setTitle:(NSString*)title;

-(void)setLeftValue:(NSString*)title;

-(void)setRightValue:(NSString*)title;

-(void)scrollToZero;

-(void)allowScroll:(BOOL)state;

@end
