//
//  BLScrollLabel.m
//  lunbo
//
//  Created by 王春龙 on 2018/3/28.
//  Copyright © 2018年 LvPoul. All rights reserved.
//

#import "BLScrollLabel.h"
#import "UIButton+Balopy.h"

typedef NS_ENUM(NSUInteger, BLScrollLabelIndex) {
    firstLabelIndex = 1342321,
    secondLabelIndex
};
@interface BLScrollLabel ()

@property(nonatomic,strong)NSTimer *changeTimer;
@property(nonatomic,assign)BLScrollLabelIndex  index;
@property(nonatomic,assign)NSInteger  count;

@end


@implementation BLScrollLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _count = 0;
        _index = firstLabelIndex;
        
        CGRect frameM = CGRectMake(0, (CGRectGetHeight(frame)-21)*0.5, CGRectGetWidth(frame), 21);
        UIButton *firstLabel = [[UIButton alloc]initWithFrame:frameM];
        firstLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        firstLabel.blFont = [UIFont systemFontOfSize:13.f];
        firstLabel.blColor = [UIColor blackColor];
        firstLabel.tag = _index;
        firstLabel.blImage = self.imageName;
        firstLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       
        [self addSubview:firstLabel];

        _changeTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(repeadFuntion) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setFont:(UIFont *)font {
    _font = font;
}

- (void)setColor:(UIColor *)color {
    _color = color;
}

- (void)setTempArray:(NSArray *)tempArray {
    
    _tempArray = tempArray;//array.mutableCopy;
    
    UIButton *firstLabel = [self viewWithTag:_index];
    firstLabel.titleLabel.text = _tempArray.firstObject;
    
}
-(void)repeadFuntion{
    
    if (_count < _tempArray.count-1) {
        
        _count ++;
    } else {
        _count = 0;
    }
    
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 21);
    UIButton *currentButton = [[UIButton alloc]initWithFrame:frame];
    currentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    currentButton.blImage = self.imageName;
    currentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   currentButton.blTitle = _tempArray[_count] ;
    currentButton.alpha = 0.3;
    currentButton.blColor = _color;
    currentButton.blFont = _font;
    currentButton.touchUpInsideblock = ^(UIButton *sender) {
        if (self.scrollLabelEvent) {
            self.scrollLabelEvent(self.tempArray[self.count]);
        }
    };
    if (_index == firstLabelIndex) {
        currentButton.tag = secondLabelIndex;
    }else{
        currentButton.tag = firstLabelIndex;
    }
    [self addSubview:currentButton];

    UIButton *labelOnChangeView = [self viewWithTag:_index];
    
    labelOnChangeView.blColor = _color;
    labelOnChangeView.blFont = _font;
   
    [UIView animateWithDuration:1 animations:^{
        
        labelOnChangeView.frame = CGRectMake(0, -CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 21);
        labelOnChangeView.alpha = 0;
        currentButton.frame = CGRectMake(0, (CGRectGetHeight(frame)-21)*0.5, CGRectGetWidth(self.bounds), 21);
        
    } completion:^(BOOL finished){
        
        [labelOnChangeView removeFromSuperview];
        currentButton.alpha = 1;
    }];
    
    if (_index == firstLabelIndex) {
        _index = secondLabelIndex;
    }else{
        _index = firstLabelIndex;
    }
}


- (void)dealloc {
    [_changeTimer invalidate];
    _changeTimer = nil;
}


@end

