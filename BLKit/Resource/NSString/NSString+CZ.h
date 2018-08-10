///
///  NSString+CZ.h
///
///  Created by Vincent_Guo on 14-6-28.
///  Copyright (c) 2014年 vgios. All rights reserved.
///

#import <Foundation/Foundation.h>

#import "NNToolHeader.h"

/*! 时间格式  YYYY-MM-dd HH:mm:ss */
typedef NS_ENUM(NSUInteger, BLFormatterDateType) {
    formatter_default = 0,//YYYY-MM-dd HH:mm:ss
    formatter_MM,//YYYY-MM-dd HH:mm
    formatter_MM_dd,//MM-dd
    formatter_NO//YYYY-MM-dd
};

@interface NSString (CZ)

/** 根据日期返回字符串 */
+ (NSString *)dateCharConvertToString:(id)date formatter:(BLFormatterDateType)type;

/*!
 * 固定宽高
 * 计算 collection 整体高
 * count, 多少个 row,
 * number, 每行几个item
 * height, 行高
 * gap, 间距
 */
+ (CGSize)sizeForDropList:(NSUInteger)count numbersOfRow:(NSUInteger)number heightForRow:(CGFloat)height gap:(CGFloat)gap;

/*!
 * 动态宽
 * 计算 collection 整体高
 * count, 多少个 row,
 * height, 行高
 * gap, 横向间距
 */
+ (CGSize)sizeForDynamicDropList:(id)items heightForRow:(CGFloat)height gapForCross:(CGFloat)gap;

/** 返回分与秒的字符串 如:01:60*/
+(NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time;

/** * 删除空格 */
- (NSString *)deletSpaceInString;

/** * 解析HTML */
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

/**  * 通过. 截取字符串 */
+ (NSString *)cutOutString:(NSString *)string Char:(NSString *)chars;

/**  * 数字格式， 超过1k  进万 */
+ (NSString *) convertNumberToInteger:(int)count title:(NSString*)title;
+ (NSString *)convertMeterToKiloMeters:(CGFloat)meter;

+ (NSString *)convertTimeToString:(NSString *)timeStr;

/** md5 一般加密 */
+ (NSString *)MD5String:(NSString *)string;
/** * 牛逼加密 */
+ (NSString *)MD5StringNB:(NSString *)string;

/** * 随机生成字符串 */
+ (NSString *)generateRandomString;

/** * 判断邮箱格式 */
- (BOOL)checkInputEmail;

/** * 密码 6 ~ 20位 */
- (BOOL)checkInputPassword;

/** * 英文数字. 下划线, 横线  */
+ (BOOL)checkUserNameWithChar:(NSString *)text;
/*! 判断中文名 */
+ (BOOL) checkChineseNameWithChar:(NSString *)text;

/** *  手机号码验证 MODIFIED BY HELENSONG */
- (BOOL)checkMobileNumber;
/** 检测输入QQ号 */
- (BOOL)checkInputQQ;

+ (BOOL)chcekFixphoneWithChar:(NSString *)text;

+ (NSString *)cutOutStringWithPeriod:(NSString *)string;

+ (NSDictionary *)getParagraphStyleFontSize:(CGFloat)font color:(UIColor *)color firstLineHeadIndent:(CGFloat)headIndent;

+ (NSAttributedString *)configureStringWithString:(NSString *)allString changeString:(NSString *)change color:(UIColor *)color font:(UIFont *)font changeColor:(UIColor *)changeColor changeFont:(UIFont *)changeFont;

/**
 文字的Size
 
 @param font 字体
 @param maxSize MaxSize
 @return 文字的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize ;

/**
 文字的Size
 
 @param text 文字
 @param font 字体
 @param maxSize MaxSize
 @return 文字的Size
 */
+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize ;


/**
 文字的高度
 
 @param font 字体
 @param width 限制的宽度
 @return 文字的高度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 文字的宽度
 
 @param font 字体
 @param height 限制的高度
 @return 文字的宽度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;


/**
 文字的Size
 
 @param font 字体
 @param width 容器的宽度
 @return 文字的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 文字的Size
 
 @param font 字体
 @param height 容器的高度
 @return 文字的Size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 String的二维码信息
 
 @return String的二维码图片
 */
- (UIImage *)QRcode;

/**  是否包含Emoji */
- (BOOL)isIncludingEmoji;

/**  移除EmojiString标签 */
- (instancetype)removedEmojiString;

/**  移除html标签 */
- (NSString *)removeHTML2:(NSString *)html;

@end
