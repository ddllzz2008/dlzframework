//
//  AddPackageView.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/25.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "AddPackageView.h"

@implementation AddPackageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    [[UIColor clearColor]set];
    
    double width = rect.size.width;
    double height = rect.size.height;
    double dis = 10;
    double borderWidth = 1.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.87, 0.87, 0.93, 1);//画笔颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);

    CGContextSetLineWidth(context, borderWidth);//线宽
    
    CGPoint aPoints[3];
    aPoints[0] = CGPointMake(width/2, 0);
    aPoints[1] = CGPointMake(width/2 - dis, dis);
    aPoints[2] = CGPointMake(width/2 + dis, dis);
    
    CGContextAddLines(context, aPoints, 3);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextMoveToPoint(context, width-borderWidth, height-20);//起点，坐标右边
    CGContextAddArcToPoint(context, width, height - borderWidth, width-20, height - borderWidth, 10);//右下角
    CGContextAddArcToPoint(context, borderWidth, height - borderWidth, borderWidth, height-20, 10);//
    CGContextAddArcToPoint(context, borderWidth, 0+dis, 20, 0+dis, 10);
    CGContextAddArcToPoint(context, width - borderWidth, 0+dis, width - borderWidth, 20+dis, 10);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1);//画笔颜色
    CGContextMoveToPoint(context, width/2 - dis, dis);
    CGPoint linePoint[2];
    linePoint[0] = CGPointMake(width/2 - dis, dis);
    linePoint[1] = CGPointMake(width/2 + dis, dis);
    CGContextAddLines(context, linePoint, 2);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
