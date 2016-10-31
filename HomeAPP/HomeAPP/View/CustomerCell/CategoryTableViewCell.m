//
//  CategoryTableViewCell.m
//  HomeAPP
//
//  Created by ddllzz on 16/5/20.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "CategoryTableViewCell.h"

@interface CategoryTableViewCell(){
    __strong UIView *pointView;
    __strong UILabel *currentLabel;
    __strong UIScrollView *scrollCell;
    
    float _oldX;
    int direction;
}
@end

@implementation CategoryTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath*)indexpath{
    static NSString *identifier = @"CategoryTableViewCell";
    
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier indexpath:indexpath];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexpath:(NSIndexPath*)indexpath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGSize size = self.contentView.frame.size;
        
        scrollCell = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, size.width, 60)];
        scrollCell.contentSize =CGSizeMake(size.width + 80, 0);
        scrollCell.showsHorizontalScrollIndicator=NO;
        scrollCell.bounces = NO;
        scrollCell.delegate=self;
        [self.contentView addSubview:scrollCell];
        
        pointView = [UIView new];
        pointView.layer.cornerRadius = 5;
        pointView.clipsToBounds=YES;
        [scrollCell addSubview:pointView];
        [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(scrollCell).with.offset(10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(size.width-20, size.height));
        }];
        
        currentLabel = [UILabel new];
        currentLabel.textAlignment=NSTextAlignmentLeft;
        [currentLabel styleForNormal];
        [pointView addSubview:currentLabel];
        [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(pointView).with.offset(5);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(size.width/2, size.height));
        }];
        
        UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width, 12.5, 35, 35)];
        [editBtn setBackgroundImage:[UIImage imageNamed:@"common_edit"] forState:UIControlStateNormal];
        [editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        editBtn.userInteractionEnabled=YES;
        [scrollCell addSubview:editBtn];
        
        UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(size.width + 40, 12.5, 35, 35)];
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"common_delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollCell addSubview:deleteBtn];
        
        [scrollCell setBackgroundColor:[UIColor clearColor]];
        
        self.contentView.frame=CGRectMake(0,0, size.width+80, 44);
    }
    
    NSArray *subviews = [scrollCell subviews];
    for(id view in subviews)
    {
        if([view isKindOfClass:[UIButton class]])
        {
            [view setTag:[indexpath row]];
            [self.contentView bringSubviewToFront:view];
        }
    }
    
    _oldX = 0;
    direction = 0;
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSArray *list = [self subviews];
    if (list.count>1) {
        UIView *view = [list objectAtIndex:0];
        view.frame=CGRectMake(0, 0, ScreenSize.width, 60);
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark---customer method
-(void)setPointColor:(long)color{
    pointView.backgroundColor=UIColorFromRGB(color);
}

-(void)setTitle:(NSString*)title{
    currentLabel.text=title;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float newX = 0;
    
    newX = scrollView.contentOffset.x;
    if (newX != _oldX) {
        if (newX > _oldX && (newX - _oldX) > 100) {
            direction = 0;//左滑
            _oldX = newX;
        } else if (newX < _oldX && (_oldX - newX) > 100) {
            direction = 1;//右滑
            _oldX = newX;
        }
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerat{
    
    if (direction==0) {
        if (scrollView.contentOffset.x > 20) {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 [scrollView setContentOffset:CGPointMake(80, 0)];
                             }];
            [UIView animateWithDuration:0.25 animations:^{
                [scrollView setContentOffset:CGPointMake(80, 0)];
            } completion:^(BOOL finished) {
                if (self.moveComplete!=nil) {
                    __weak CategoryTableViewCell *cell = self;
                    self.moveComplete(cell);
                }
            }];
        }else{
            [UIView animateWithDuration:0.25
                             animations:^{
                                 [scrollView setContentOffset:CGPointMake(0, 0)];
                             }];
        }
    }
}

-(void)allowScroll:(BOOL)state{
    scrollCell.scrollEnabled=state;
    if (state==NO) {
        scrollCell.userInteractionEnabled = NO;
        [self.contentView addGestureRecognizer:scrollCell.panGestureRecognizer];
    }
}

#pragma mark---操作
-(void)scrollToZero{
    [UIView animateWithDuration:0.25
                     animations:^{
                         [scrollCell setContentOffset:CGPointMake(0, 0)];
                     } completion:^(BOOL finished) {
                         if (self.resetComplete!=nil) {
                             __weak CategoryTableViewCell *cell = self;
                             self.resetComplete(cell);
                         }
                     }];
}
-(void)edit:(id)sender{
    if (self.editAction!=nil) {
        self.editAction(((UIButton*)sender).tag);
    }
}

-(void)delete:(id)sender{
    if (self.deleteAction!=nil) {
        __weak CategoryTableViewCell *cell = self;
        self.deleteAction(((UIButton*)sender).tag,cell);
    }
}

@end
