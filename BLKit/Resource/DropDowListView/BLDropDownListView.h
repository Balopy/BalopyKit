//
//  BLKit.h
//  268EDU_Demo
//
//  Created by 王春龙 on 2018/7/31.
//  Copyright © 2018年 edu268. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BLDropDownListItem;

@protocol BLDropDownListViewDelegate <NSObject>

@optional
- (void)didSelectedForSub:(BLDropDownListItem *)model;
@end

@interface BLDropDownListView : UIView

@property (nonatomic, strong) NSArray *subjects;

@property (nonatomic, weak) id <BLDropDownListViewDelegate> dropDelegate;



@end
