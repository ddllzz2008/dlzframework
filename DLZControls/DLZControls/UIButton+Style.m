//
//  UIButton+Style.m
//  DLZControls
//
//  Created by ddllzz2008 on 16/2/20.
//  Copyright (c) 2016年 李方超. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

-(void)styleCorner{
    
}

-(void)styleForHeader{
    [self setTitleColor:UIColorFromRGB(color_blue_01) forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
}

-(void)styleForNormal{
    [self setTitleColor:UIColorFromRGB(color_black_01) forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
}

@end
