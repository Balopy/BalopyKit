//
//  UIColor+NNColor.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (NNColor)

/**
 * 使用16进制数字创建颜色
 */
+ (instancetype)nn_colorWithHex:(uint32_t)hex;

/**
 * 随机颜色
 */
+ (instancetype)nn_randomColor;

/**
 * RGB颜色
 */
+ (instancetype)nn_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

/**
 十六进制字符串显示颜色
 
 @param color 十六进制字符串
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)nn_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 *  @brief  渐变颜色
 *
 *  @param fromColor  开始颜色
 *  @param toColor    结束颜色
 *  @param height     渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)nn_gradientFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(CGFloat)height;

@end
