//
//  BLGeneralControl.h
//  268EDU_Demo
//
//  Created by Balopy on 2017/7/31.
//  Copyright © 2017年 edu268. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLGeneralControl : NSObject

/*! 创建 label
 *color: textcolor
 * font: CGfloat
 * view: 加到这个view 上
 */

+ (UILabel *) createUILabelWithTextColor:(UIColor *)color Font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment fromView:(id)view;


/*! 创建一个view */
+ (UIView *) createUIViewWithBackColor:(UIColor *)color addViewTo:(id)view;

/*! 创建一个Button，字号，字体颜色 */
+ (UIButton *) createUIButtonFont:(CGFloat)font titleColor:(UIColor *)color addViewTo:(id)view;
/*! 创建带背景图片的button */
+ (UIButton *) createUIButtonWithBackgroundImageName:(NSString *)normalIcon selectedIcon:(NSString *)selectedIcon addViewTo:(id)view;

/*! 创建带图片的button */
+ (UIButton *) createUIButtonWithImageName:(NSString *)normalIcon selectedIcon:(NSString *)selectedIcon addViewTo:(id)view;

/*! 创建imageView */
+ (UIImageView *) createUIImageViewWithName:(NSString *)name toView:(id)view;


/*! 创建 UITextField */
+ (UITextField *)createUITextFieldWithColor:(UIColor *)color font:(CGFloat)font placeholder:(NSString *)placeholder textAlignment:(NSTextAlignment)textAlignment toView:(id)view;


+ (UIWindow *)lastWindow;


@end

