//
//  UIView+ExtMethod.m
//  DLZHelpers
//
//  Created by ddllzz on 16/4/21.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "UIView+ExtMethod.h"

@implementation UIView (ExtMethod)

/*
 *-----------------UIView截屏------------------------*
 */
- (UIImage *)snapshot
{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO,0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
/*
 *-----------------获取UIView所在的ViewController------------------------*
 */
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
