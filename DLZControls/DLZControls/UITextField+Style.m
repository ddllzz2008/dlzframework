//
//  UITextField+Style.m
//  DLZControls
//
//  Created by ddllzz2008 on 16/2/20.
//  Copyright (c) 2016年 李方超. All rights reserved.
//

#import "UITextField+Style.h"

@implementation UITextField (Style)

-(void)styleForNormal{
    CGRect rect = self.frame;
    rect.size.height=30;
    self.frame=rect;
}

@end
