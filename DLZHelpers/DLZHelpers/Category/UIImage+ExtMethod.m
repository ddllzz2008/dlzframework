//
//  UIImage+ExtMethod.m
//  DLZHelpers
//
//  Created by ddllzz on 16/8/3.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "UIImage+ExtMethod.h"

@implementation UIImage (ExtMethod)
/*!
 *  @brief 缩放UIImage到指定尺寸
 *
 *  @param img  要缩放的UIImage
 *  @param size 要缩放到的目标尺寸
 *
 *  @return 被缩放后的UIImage
 */
- (UIImage *)scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
