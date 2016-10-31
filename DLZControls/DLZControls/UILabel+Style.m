//
//  UILabel+Style.m
//  DLZControls
//
//  Created by 李方超 on 15/11/18.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "UILabel+Style.h"

@implementation UILabel (Style)

#pragma mark---white style

-(void)styleForHeader{
    self.textColor = UIColorFromRGB(color_white_01);
    self.font = [UIFont fontWithName:@"Arial" size:20];
}

-(void)styleForContent{
    self.textColor = UIColorFromRGB(color_white_01);
    self.font = [UIFont fontWithName:@"Arial" size:18];
}

-(void)styleForTitle{
//    self.textColor = UIColorFromRGB(color_gray_01);
    self.textColor=UIColorFromRGB(color_black_01);
    self.font = [UIFont fontWithName:@"Arial" size:18];
}

-(void)styleForFilter{
    self.textColor = UIColorFromRGB(color_white_01);
    self.font = [UIFont fontWithName:@"Arial" size:14];
}

-(void)styleForNormal{
    self.textColor = UIColorFromRGB(color_white_01);
    self.font = [UIFont fontWithName:@"Arial" size:16];
}

#pragma mark---black style
-(void)styleForTitleBlack{
    self.textColor = UIColorFromRGB(color_black_01);
    self.font = [UIFont fontWithName:@"Arial" size:18];
}
-(void)styleForNormalBlack{
    self.textColor = UIColorFromRGB(color_black_01);
    self.font = [UIFont fontWithName:@"Arial" size:16];
}

-(void)styleForSmallBlack{
    self.textColor = UIColorFromRGB(color_black_01);
    self.font = [UIFont fontWithName:@"Arial" size:14];
}

@end
