//
//  CategoryCollectionViewCell.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong,readwrite) UILabel *labelTitle;

@property (nonatomic,strong,readwrite) UIImageView *addImgView;

-(void)setTitle:(NSString *)text;

-(NSString *)getTitle;

-(void)showAddImage;

@end
