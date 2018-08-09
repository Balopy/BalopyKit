//
//  BLScrollLabel.h
//  lunbo
//
//  Created by 王春龙 on 2018/3/28.
//  Copyright © 2018年 LvPoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLScrollLabel : UIView

@property (nonatomic, strong) NSArray *tempArray;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *imageName;


/*! 回调 */
@property (nonatomic, copy) void (^scrollLabelEvent) (id paramer);
@end

