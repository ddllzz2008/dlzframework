//
//  DLZCombox.m
//  DLZControls
//
//  Created by ddllzz on 16/3/30.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DLZCombox.h"

@interface DLZCombox(){
    
    __weak UIView *controllerView;
    
    UILabel *downIcon;
    UILabel *labeldefault;
    
    UIView *downView;
    UIScrollView *scroll;
    
    CGRect defaultFrame;
    double defaultHeight;
    
    UIButton *lastButton;
    
    //private field
//    BOOL isLoaded;
    NSMutableArray *buttonArray;
    BOOL isOpened;
}

@end

@implementation DLZCombox

@synthesize source;

-(id)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        downIcon =[[UILabel alloc] init];
        downIcon.text=@"▼";
        
//        isLoaded = NO;
        isOpened=NO;
        
        downView=[[UIView alloc]init];
        
        buttonArray = [[NSMutableArray alloc] init];
    }
    [self addObserver:self forKeyPath:@"source" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"source"] && [object isKindOfClass:[DLZCombox class]]) {
        for (UIView* v in self.subviews) {
            [v removeFromSuperview];
        }
        [self setNeedsDisplay];
    }else if ([keyPath isEqualToString:@"frame"] && [object isKindOfClass:[DLZCombox class]]){
        defaultFrame = [[change objectForKey:@"new"] CGRectValue];
        defaultFrame = CGRectMake(defaultFrame.origin.x, defaultFrame.origin.y, defaultFrame.size.width, defaultHeight);
        
        if (controllerView==nil) {
            controllerView = [self viewController].view;
        }
        CGPoint originInSuperview = [controllerView convertPoint:CGPointZero fromView:self];
        double scrollHeight = self.source.count*self.lineheight;
        double _scrollH = 0;
        if (scrollHeight+originInSuperview.y+self.lineheight>=ScreenSize.height) {
            _scrollH = ScreenSize.height - self.lineheight - originInSuperview.y -50;
        }else{
            _scrollH = scrollHeight;
        }
        scroll.frame=CGRectMake(0, self.lineheight, defaultFrame.size.width, _scrollH);
        
        for (int i=0; i<buttonArray.count; i++) {
            UIButton *btn = [buttonArray objectAtIndex:i];
            if (btn!=nil) {
                btn.frame = CGRectMake(5, i * self.lineheight, defaultFrame.size.width-5, self.lineheight);
            }
        }
        
        CGSize size = defaultFrame.size;
        CGSize downsize = [downIcon getLabelSize:CGSizeMake(size.width/2, defaultHeight)];
        downIcon.frame=CGRectMake(size.width-downsize.width-6, 0, downsize.width+6, defaultHeight);
    }
}

-(void)drawRect:(CGRect)rect{
    @try {
        if (buttonArray==nil) {
            buttonArray = [[NSMutableArray alloc] init];
        }
        [buttonArray removeAllObjects];
        defaultFrame = self.frame;
        defaultHeight = defaultFrame.size.height;
        CGSize size = self.frame.size;
        if (source!=nil && source.count>0) {
            NSString *str = [source objectAtIndex:0];
            if (![str isBlankString]) {
                
                downIcon.textAlignment=NSTextAlignmentCenter;
                downIcon.textColor=self.textColor;
                downIcon.font=self.font;
                CGSize downsize = [downIcon getLabelSize:CGSizeMake(size.width/2, size.height)];
                downIcon.frame=CGRectMake(size.width-downsize.width-6, 0, downsize.width+6, size.height);
                [self addSubview:downIcon];
                
                CGFloat lablewidth = size.width-downsize.width-5;
                
                labeldefault = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, lablewidth, size.height)];
                labeldefault.text=str;
                labeldefault.textColor=self.textColor;
                labeldefault.font=self.font;
                labeldefault.textAlignment=NSTextAlignmentLeft;
                [self addSubview:labeldefault];
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
                tap.delegate=self;
                tap.numberOfTapsRequired=1;
                labeldefault.userInteractionEnabled=YES;
                [labeldefault addGestureRecognizer:tap];
                
                tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
                tap.delegate=self;
                downIcon.userInteractionEnabled=YES;
                [downIcon addGestureRecognizer:tap];
                
                if (self.lineheight==0) {
                    self.lineheight=size.height;
                }
                
                if (controllerView==nil) {
                    controllerView = [self viewController].view;
                }
                CGPoint originInSuperview = [controllerView convertPoint:CGPointZero fromView:self];
                double scrollHeight = self.source.count*self.lineheight;
                double _scrollH = 0;
                if (scrollHeight+originInSuperview.y+self.lineheight>=ScreenSize.height) {
                    _scrollH = ScreenSize.height - self.lineheight - originInSuperview.y -50;
                }else{
                    _scrollH = scrollHeight;
                }
                
                scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.lineheight, size.width, _scrollH)];
                scroll.contentSize=CGSizeMake(size.width, self.source.count*self.lineheight);
                scroll.showsVerticalScrollIndicator=NO;
                [self addSubview:scroll];
                
                UITapGestureRecognizer *itemTap;
                
                for (int i=0; i<self.source.count; i++) {
                    UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(5, i * self.lineheight, size.width-5, self.lineheight)];
                    [item setTitle:[self.source objectAtIndex:i] forState:UIControlStateNormal];
                    [item setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    item.titleLabel.font=self.font;
                    if ([labeldefault.text isEqualToString:item.titleLabel.text]) {
                        lastButton = item;
                        [item setTitleColor:UIColorFromRGB(color_gray_02) forState:UIControlStateNormal];
                    }else{
                        [item setTitleColor:self.textColor forState:UIControlStateNormal];
                    }
                    itemTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemDidClick:)];
                    itemTap.delegate=self;
                    itemTap.numberOfTapsRequired=1;
                    //                UIView *tapView = [itemTap view];
                    item.tag=i;
                    item.userInteractionEnabled=YES;
                    [item addGestureRecognizer:itemTap];
                    [item addTarget:self action:@selector(itemDidClick:) forControlEvents:UIControlEventTouchUpInside];
                    [scroll addSubview:item];
                    if (buttonArray!=nil) {
                        [buttonArray addObject:item];
                    }
                }
//            isLoaded=YES;
            }
        }
    }
    @catch (NSException *exception) {
//        DDLogDebug()
    }
    @finally {
        
    }
    
}

#pragma mark---event handler
-(void)viewClick:(id)sender{
    if (isOpened) {
        self.frame =defaultFrame;
        downIcon.text=@"▼";
        isOpened=NO;
    }
    else{
        CGRect frame = self.frame;
        [UIView transitionWithView:self duration:0.3 options:0 animations:^{
            self.frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + self.lineheight*self.source.count);
        } completion:^(BOOL finished) {
            downIcon.text=@"▲";
            isOpened=YES;
        }];
    }
}

-(void)itemDidClick:(UITapGestureRecognizer*)sender{
    if(![sender isKindOfClass:[UITapGestureRecognizer class]]){
        return;
    }
    UITapGestureRecognizer *tap = sender;
    UIButton *btn = (UIButton*)tap.view;
    BOOL startDelegate=NO;
    if (btn!=nil) {
        if ([labeldefault.text isEqualToString:btn.titleLabel.text]) {
            startDelegate=NO;
        }else{
            labeldefault.text = btn.titleLabel.text;
            startDelegate=YES;
        }
        self.frame =defaultFrame;
        downIcon.text=@"▼";
    }else{
        self.frame =defaultFrame;
        downIcon.text=@"▼";
    }
    if (lastButton!=nil) {
        [lastButton setTitleColor:self.textColor forState:UIControlStateNormal];
    }
    lastButton = btn;
    [btn setTitleColor:UIColorFromRGB(color_gray_02) forState:UIControlStateNormal];
    isOpened=NO;
    
    if (startDelegate && self.delegate!=nil) {
        [self.delegate DLZCombox:self didSelectedItemAtIndex:btn.tag];
    }
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"source"];
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
