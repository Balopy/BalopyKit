///
///  BLDropDownCollectionCell.m
///  268EDU_Demo
///
///  Created by yzla50010 on 16/8/24.
///  Copyright © 2016年 edu268. All rights reserved.
///

#import "BLDropDownCollectionCell.h"
#import "BLDropDownListItem.h"

@interface BLDropDownCollectionCell ()
@property (strong, nonatomic) UIButton *itemBtn;

@end

@implementation BLDropDownCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.itemBtn = [[UIButton alloc] init];
        self.itemBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        self.itemBtn.userInteractionEnabled = NO;
        self.itemBtn.frame = self.bounds;
        [self.contentView addSubview:self.itemBtn];
        
    }
    return self;
}



- (void)setModel:(BLDropDownListItem *)model
{
    _model = model;
    
    [self.itemBtn setTitle:model.name forState:UIControlStateNormal];
   
    if (model.isSelected) {
       
        [self.itemBtn setBackgroundImage:[UIImage imageNamed:@"blue_classBtn"] forState:UIControlStateNormal];
        [self.itemBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
     
        [self.itemBtn setBackgroundImage:[UIImage imageNamed:@"矩形-31-拷贝-2"] forState:UIControlStateNormal];
        [self.itemBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}





@end
