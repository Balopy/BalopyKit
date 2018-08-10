//
//  UILabel+NNLabel.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (NNLabel)

/** 快速创建 */
+ (instancetype)nn_labelWithText:(NSString *)text textFont:(int)font textColor:(UIColor *)color frame:(CGRect)frame;

/** 设置字间距 */
- (void)setColumnSpace:(CGFloat)columnSpace;

/** 设置行距 */
- (void)setRowSpace:(CGFloat)rowSpace;

@end
