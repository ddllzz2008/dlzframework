//
//  DrawLineView.h
//  DLZControls
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLineView : UIView

@property (nonatomic,readwrite) CGFloat lineWidth;

@property (nonatomic,readwrite) long lineColor;

@property (nonatomic,readwrite) CGPoint startPoint;

@property (nonatomic,readwrite) CGPoint endPoint;

@end
