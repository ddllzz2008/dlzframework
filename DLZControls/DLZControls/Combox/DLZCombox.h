//
//  DLZCombox.h
//  DLZControls
//
//  Created by ddllzz on 16/3/30.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+ExtMethod.h"
#import "UILabel+extmethod.h"
#import "UIView+ExtMethod.h"

@protocol DLZComboxDelegate <NSObject>

@optional
-(void)DLZCombox:(UIView*)combox didSelectedItemAtIndex:(NSInteger)index;

@end

@interface DLZCombox : UIView<UIGestureRecognizerDelegate>

@property (nonatomic,strong) NSArray *source;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,strong) UIFont *font;

@property (nonatomic,readwrite) CGFloat lineheight;

@property (nonatomic,weak) id<DLZComboxDelegate> delegate;

@end
