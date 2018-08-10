//
//  BLScrollLabel.h
//  lunbo
//
//  Created by 王春龙 on 2018/3/28.
//  Copyright © 2018年 LvPoul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLScrollLabel : UIView

- (instancetype)initWithFrame:(CGRect)frame textFont:(UIFont *)textFont textColor:(UIColor *)textColor imageName:(NSString *)imageName textArray:(NSArray *)textArray;

/*! 回调 */
@property (nonatomic, copy) void (^scrollLabelEvent) (id paramer);
@end

