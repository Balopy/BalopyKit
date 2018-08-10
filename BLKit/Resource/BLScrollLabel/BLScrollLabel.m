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

@property (nonatomic,strong) NSTimer *changeTimer;
@property (nonatomic,assign) BLScrollLabelIndex  index;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic, strong) NSArray *tempArray;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *imageName;

@end

@implementation BLScrollLabel

- (instancetype)initWithFrame:(CGRect)frame textFont:(UIFont *)textFont textColor:(UIColor *)textColor imageName:(NSString *)imageName textArray:(NSArray *)textArray {
    if (self = [super initWithFrame:frame]) {
        _count = 0;
        _index = firstLabelIndex;
        self.font = textFont;
        self.color = textColor;
        self.imageName = imageName;
        self.tempArray = textArray;
        self.clipsToBounds = YES;
        CGRect frameM = CGRectMake(0, (CGRectGetHeight(frame)-CGRectGetHeight(self.frame))*0.5, CGRectGetWidth(frame), CGRectGetHeight(self.frame));
        UIButton *firstLabel = [[UIButton alloc]initWithFrame:frameM];
        firstLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        firstLabel.blFont = [UIFont systemFontOfSize:13.f];
        firstLabel.blColor = [UIColor blackColor];
        firstLabel.tag = _index;
        firstLabel.blImage = self.imageName;
        [firstLabel setTitle:_tempArray.firstObject forState:UIControlStateNormal];
        firstLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.clipsToBounds = YES;
        [self addSubview:firstLabel];
        _changeTimer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(repeadFuntion) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)repeadFuntion {
    if (_count < _tempArray.count-1) {
        _count ++;
    } else {
        _count = 0;
    }
    
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
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
    } else {
        currentButton.tag = firstLabelIndex;
    }
    [self addSubview:currentButton];
    
    UIButton *labelOnChangeView = [self viewWithTag:_index];
    
    labelOnChangeView.blColor = _color;
    labelOnChangeView.blFont = _font;
    
    [UIView animateWithDuration:1 animations:^{
        labelOnChangeView.frame = CGRectMake(0, -CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        labelOnChangeView.alpha = 0.3;
        currentButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } completion:^(BOOL finished){
        [labelOnChangeView removeFromSuperview];
        currentButton.alpha = 1;
    }];
    
    if (_index == firstLabelIndex) {
        _index = secondLabelIndex;
    } else {
        _index = firstLabelIndex;
    }
}

- (void)dealloc {
    [_changeTimer invalidate];
    _changeTimer = nil;
}

@end
