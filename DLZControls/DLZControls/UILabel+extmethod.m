//
//  UILabel+extmethod.m
//  DLZControls
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "UILabel+extmethod.h"

@implementation UILabel (extmethod)

-(CGSize)getLabelSize:(CGSize)maxsize{
    [self setNumberOfLines:1];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelsize = [self.text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return labelsize;
}

-(CGSize)getmutliLineSize:(CGSize)maxsize{
    [self setNumberOfLines:0];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelsize = [self.text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return labelsize;
}

@end
