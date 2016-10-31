//
//  CategoryTableViewCell.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/20.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (copy) void(^editAction)(NSInteger);
@property (copy) void(^deleteAction)(NSInteger,CategoryTableViewCell*);
@property (copy) void(^moveComplete)(CategoryTableViewCell*);
@property (copy) void(^resetComplete)(CategoryTableViewCell*);

+ (instancetype)cellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath*)indexpath;

-(void)setPointColor:(long)color;

-(void)setTitle:(NSString*)title;

-(void)scrollToZero;

-(void)allowScroll:(BOOL)state;

@end
