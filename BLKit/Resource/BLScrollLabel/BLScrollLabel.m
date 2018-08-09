//
//  BLScrollLabel.m
//  lunbo
//
//  Created by 王春龙 on 2018/3/28.
//  Copyright © 2018年 LvPoul. All rights reserved.
//

#import "BLScrollLabel.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface BLScrollLabel ()

@property(nonatomic,strong)NSTimer *changeTimer;
@property(nonatomic,assign)NSInteger  index;
@property(nonatomic,assign)NSInteger  count;

@end


@implementation BLScrollLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _count = 0;
        _index = 1;
        
        CGRect frameM = CGRectMake(0, 0, CGRectGetWidth(frame), 21);
        UIButton *firstLabel = [[UIButton alloc]initWithFrame:frameM];
        firstLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        firstLabel.titleLabel.font = [UIFont systemFontOfSize:13.f];
        firstLabel.titleLabel.textColor = [UIColor blackColor];
        firstLabel.tag = _index;
        [firstLabel setImage:[UIImage imageNamed:self.imageName] forState:UIControlStateNormal];
        [self addSubview:firstLabel];
        
        firstLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
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
    
    CGRect frame = CGRectMake(0, 21, CGRectGetWidth(self.bounds), 21);
    UIButton *currentButton = [[UIButton alloc]initWithFrame:frame];
    currentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    [currentButton setImage:[UIImage imageNamed:self.imageName] forState:UIControlStateNormal];
    currentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [currentButton setTitle:_tempArray[_count] forState:UIControlStateNormal];
    currentButton.alpha = 0.3;
    currentButton.titleLabel.textColor = _color;
    currentButton.titleLabel.font = _font;
    [currentButton addTarget:self action:@selector(labelButtonClock:) forControlEvents:UIControlEventTouchUpInside];
    if (_index == 1) {
        currentButton.tag = 2;
    }else{
        currentButton.tag = 1;
    }
    [self addSubview:currentButton];

    
    
    UIButton *labelOnChangeView = [self viewWithTag:_index];
   
    
    
    labelOnChangeView.titleLabel.textColor = _color;
    labelOnChangeView.titleLabel.font = _font;
    [UIView animateWithDuration:1 animations:^{
        
        labelOnChangeView.frame = CGRectMake(0, -21, CGRectGetWidth(self.bounds), 21);
        labelOnChangeView.alpha = 0;
        currentButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 21);
        
    } completion:^(BOOL finished){
        
        [labelOnChangeView removeFromSuperview];
        currentButton.alpha = 1;
    }];
    
    if (_index == 1) {
        _index = 2;
    }else{
        _index = 1;
    }
}

- (void) labelButtonClock:(UIButton *)sender {
    
    if (self.scrollLabelEvent) {
        self.scrollLabelEvent(_tempArray[_count]);
    }
}

- (void)dealloc {
    [_changeTimer invalidate];
    _changeTimer = nil;
}


@end

