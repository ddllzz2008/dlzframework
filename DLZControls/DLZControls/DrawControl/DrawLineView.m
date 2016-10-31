//
//  DrawLineView.m
//  DLZControls
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DrawLineView.h"

@implementation DrawLineView

- (void)drawRect:(CGRect)rect {
    
//    NSString *colorstring = [NSString stringWithFormat:@"%ld",self.lineColor];
    NSString *colorstring = @"999999";
    colorstring = [colorstring stringByReplacingOccurrencesOfString:@"#" withString:@""];
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[colorstring substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[colorstring substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[colorstring substringWithRange:range]]scanHexInt:&blue];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, red / 255.0, green / 255.0, blue / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, self.startPoint.x, self.startPoint.y);  //起点坐标
    CGContextAddLineToPoint(context, self.endPoint.x,self.endPoint.y);   //终点坐标
    
    CGContextStrokePath(context);
}

@end
