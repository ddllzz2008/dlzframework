//
//  CategoryCollectionViewCell.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.labelTitle styleForNormal];
        self.labelTitle.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:self.labelTitle];
        
        self.addImgView = [UIImageView new];
        [self.addImgView setImage:[UIImage imageNamed:@"common_add"]];
        [self.contentView addSubview:self.addImgView];
        [self.addImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(29, 29));
            make.center.equalTo(self.contentView);
        }];
        
        self.addImgView.alpha = 0.0;
        
        self.layer.cornerRadius=4;
        self.clipsToBounds=YES;
    }
    return self;
}

#pragma mark---property setter
-(void)setTitle:(NSString *)text{
    if (self.addImgView!=nil) {
        self.addImgView.alpha = 0.0;
    }
    self.labelTitle.text=@"";
    [self.labelTitle setText:text];
}

-(void)showAddImage{
    if (self.labelTitle!=nil) {
        self.labelTitle.text=@"";
    }
    if (self.addImgView!=nil) {
        self.addImgView.alpha = 1.0;
    }
}

-(NSString *)getTitle{
    return self.labelTitle.text;
}

@end
