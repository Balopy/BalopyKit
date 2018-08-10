///
///  NSString+CZ.m
///
///  Created by Vincent_Guo on 14-6-28.
///  Copyright (c) 2014年 vgios. All rights reserved.
///

#import "NSString+CZ.h"
#import "NNToolHeader.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (CZ)

+ (NSString *)dateCharConvertToString:(id)date formatter:(BLFormatterDateType)type {
    
    //时间格式的字符串
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //格式转换，格式必须与时间字符串保持一致, 否则将得不到时间
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *nowtimeStr;
    if ([date isKindOfClass:[NSString class]]) {
        //将格式一致的 时间字符串 按设定的时间格式，转换成时间戳
        nowtimeStr = [formatter dateFromString:date];
    } else if ([date isKindOfClass:[NSDate class]]) {
        nowtimeStr = date;
    } else {
        nowtimeStr = [NSDate date];
    }
    //将时间戳按格式进行格式化
    
    if (type == formatter_default) {
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    } else if (type == formatter_MM) {
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    } else if (type == formatter_MM_dd){
       
        [formatter setDateFormat:@"MM-dd"];
    } else {
        [formatter setDateFormat:@"YYYY-MM-dd"];
    }
    // 转换成字符串
    NSString *confromTimespStr = [formatter stringFromDate:nowtimeStr];
    
    return confromTimespStr;
}


/*! 传一个时间格式的字符串, 返回一个时间字符串 */
+ (NSString *)convertTimeToString:(NSString *)timeStr {
    
    //   设置时间显示格式:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate *nowtimeStr = [formatter dateFromString:timeStr];//----------将nsdate按formatter格式转成nsstring
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSString *confromTimespStr = [formatter stringFromDate:nowtimeStr];
    
    if (!confromTimespStr) {
        NSDate *tmpDate = [NSDate date];
        confromTimespStr = [formatter stringFromDate:tmpDate];
    }
    return confromTimespStr;
}

/*!计算 collection 整体高
 * count, 多少个 row,
 * number, 每行几个item
 * height, 行高
 */
+ (CGSize) sizeForDropList:(NSUInteger)count numbersOfRow:(NSUInteger)number heightForRow:(CGFloat)height gap:(CGFloat)gap {
 
    NSUInteger conslut = count/number;
    NSUInteger remaining = (count%number == 0) ? 0 : 1;
    
    CGFloat h = ((conslut + remaining) * (height + gap)) + gap;
    
    CGSize size = (CGSize){NNScreen_width, h};
    
    return size;
}

+ (CGSize) sizeForDynamicDropList:(id)items  heightForRow:(CGFloat)height gapForCross:(CGFloat)gap {

    for (int i = 0; i < [items count]; i++)
    {
    }


    CGSize size = (CGSize){NNScreen_width, 0};
    
    return size;

}

+ (NSString *)getMinuteSecondWithSecond:(NSTimeInterval)time{
    
    int minute = (int)time / 60;
    int second = (int)time % 60;
    
    if (second > 9) { ///2:10
        return [NSString stringWithFormat:@"%d:%d",minute,second];
    }
    
    ///2:09
    return [NSString stringWithFormat:@"%d:0%d",minute,second];
}

- (NSString *)deletSpaceInString {
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; /// 去首尾空格
    NSString *replace = [content stringByReplacingOccurrencesOfString:@" " withString:@""];/// 去全部空格
    return replace;
}

+ (NSString *)cutOutString:(NSString *)string Char:(NSString *)chars {
    NSArray *strings = [string componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"。."]];
    
    NSString *periodString = [strings firstObject];
    
    return periodString;
}

#pragma mark - 解析HTML
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        /// find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        /// find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        /// replace the found tag with a space
        ///(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[ NSString stringWithFormat:@"%@>", text] withString:@""];
        
        if ([html containsString:@"</p><p>"]) {
            NSString *replace = [html stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"];
            
            html = replace;
        }
        if ([html containsString:@"&nbsp;"]) {
            NSString *replace = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
            html = replace;
        }
        if ([html containsString:@"_ueditor_page_break_tag_"]) {
            NSString *replace = [html stringByReplacingOccurrencesOfString:@"_ueditor_page_break_tag_" withString:@" "];
            
            html = replace;
        }
    }
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

+ (NSString *)convertMeterToKiloMeters:(CGFloat)meter {
    
    NSString *title = @"";
    if (meter < 1000) { /// 不足10000：直接显示数字，比如786、7986
        title = [title stringByAppendingString:[NSString stringWithFormat:@"%.1f m", meter]];
    } else { /// 达到10000：显示xx.x万，不要有.0的情况
        double wan = meter / 1000.0 + 0.05; //四舍五入
        title = [title stringByAppendingString:[NSString stringWithFormat:@" %.2fkm", wan]];
        /// 将字符串里面的.0去掉
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    return title;
}

+ (NSString *) convertNumberToInteger:(int)count title:(NSString*)title {
 
    if (!title) title = @"";
    
    /// 数字不为0
    if (count < 10000) {
        
        /// 不足10000：直接显示数字，比如786、7986
        title = [NSString stringWithFormat:@"%@%d", title, count];
    } else {
       
        /// 达到10000：显示xx.x万，不要有.0的情况
        double wan = count / 10000.0 + 0.05;
      
        title = [NSString stringWithFormat:@"%@%.1f万", title, wan];

        /// 将字符串里面的.0去掉
        title = [title stringByReplacingOccurrencesOfString:@" .0" withString:@""];
    }
    return title;
}

/** md5 一般加密 */
+ (NSString *)MD5String:(NSString *)string {
    const char *myPasswd = [string UTF8String];
    
    unsigned char mdc[16];
    
    CC_MD5(myPasswd, (CC_LONG)strlen(myPasswd), mdc);
    
    NSMutableString *md5String = [NSMutableString string];
    
    for (int i = 0; i< 16; i++) {
        [md5String appendFormat:@"%02x",mdc[i]];
    }
    
    return md5String;
    
}

/** md5 NB(牛逼的意思)加密*/
+ (NSString *)MD5StringNB:(NSString *)string {
    const char *myPasswd = [string UTF8String];
    
    unsigned char mdc[16];
    
    CC_MD5(myPasswd, (CC_LONG)strlen(myPasswd), mdc);
    
    NSMutableString *md5String = [NSMutableString string];
    
    [md5String appendFormat:@"%02x",mdc[0]];
    
    for (int i = 1; i< 16; i++) {
        [md5String appendFormat:@"%02x",mdc[i]^mdc[0]];
    }
    
    return md5String;
}

/** * 随机生成字符串 */
+ (NSString *)generateRandomString{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        } else {
            int figure = (arc4random() % 26) + 'a';
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    
    return string;
}

#pragma mark ---- 判断邮箱格式  ----
- (BOOL)checkInputEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
    
}

#pragma mark ---- 密码 6 ~ 20位  ----
- (BOOL)checkInputPassword{
    NSString *regex = @"\\w{6,20}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isCheck = [emailTest evaluateWithObject:self];
    return isCheck;
}

#pragma mark ---- 英文数字. 下划线, 横线  ----
+ (BOOL)checkUserNameWithChar:(NSString *)text {
    NSString *Regex = @"^[a-zA-Z0-9_\\-\u4e00-\u9fa5]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    BOOL isCheck = [emailTest evaluateWithObject:text];
    return isCheck;
}


+ (BOOL) checkChineseNameWithChar:(NSString *)text {

    NSString *Regex = @"^[\u4e00-\u9fa5]+(·[\u4e00-\u9fa5]+)*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    BOOL isCheck = [nameTest evaluateWithObject:text];
    
    if (text.length > 10) isCheck = NO;
    return isCheck;
}

+ (BOOL) chcekFixphoneWithChar:(NSString *)text {
    NSString *Regex= @"^(0[0-9]{2,3}/-)?([2-9][0-9]{6,7})+(/-[0-9]{1,4})?$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    BOOL isCheck = [nameTest evaluateWithObject:text];
    return isCheck;
}

#pragma mark ---- 手机号码验证 MODIFIED BY HELENSONG ----
- (BOOL)checkMobileNumber{
    if (self.length != 11){
        return NO;
    }
    
    NSString *emailRegex = @"^1[0-9]{10}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)checkInputQQ {
    NSString *Regex = @"\\w{6,13}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [emailTest evaluateWithObject:self];
}

+ (NSString *)cutOutStringWithPeriod:(NSString *)string
{
    NSArray *strings = [string componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"。."]];
    
    NSString *periodString = [strings firstObject];
    
    return periodString;
}

+ (NSDictionary *)getParagraphStyleFontSize:(CGFloat)font color:(UIColor *)color firstLineHeadIndent:(CGFloat)headIndent
{
    ///结构体数组,  段落布局
    ///   NSParagraphStyleAttributeName 段落的风格（设置首行，行间距，对齐方式什么的）看自己需要什么属性，写什么
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.5f;/// 字体的行间距
    paragraphStyle.firstLineHeadIndent = headIndent;///首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;///（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;///结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    paragraphStyle.minimumLineHeight = 10;///最低行高
    paragraphStyle.maximumLineHeight = 20;///最大行高
    ///paragraphStyle.paragraphSpacing = 5;///段与段之间的间距
    /// paragraphStyle.paragraphSpacingBefore = 22.0f;///段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;///从左到右的书写方向（一共➡️三种）
    paragraphStyle.lineHeightMultiple = 15;/* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
    NSDictionary *dict = @{
                           NSParagraphStyleAttributeName : paragraphStyle,
                           NSFontAttributeName: [UIFont systemFontOfSize:font],
                           NSForegroundColorAttributeName : color
                           };
    return dict;
}


+ (NSAttributedString *) configureStringWithString:(NSString *)allString changeString:(NSString *)change color:(UIColor *)color font:(UIFont *)font changeColor:(UIColor *)changeColor changeFont:(UIFont *)changeFont  {
    
    NSRange range = [allString rangeOfString:change];
    
    NSDictionary *dict = @{ NSForegroundColorAttributeName : color, NSFontAttributeName : font };
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:allString attributes:dict];
    
    // 变色
    [attributed addAttribute:NSFontAttributeName value:changeFont range:range];
    [attributed addAttribute:NSForegroundColorAttributeName value:changeColor range:range];
    
    return attributed;
}

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize{
    NSDictionary *arrts = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
}

+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxSize:(CGSize)maxSize{
    return [text sizeWithFont:font andMaxSize:maxSize];
}

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.height);
}

/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return ceil(textSize.width);
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height{
    UIFont *textFont = font ? font : [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    CGSize textSize;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 70000
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                     NSParagraphStyleAttributeName: paragraph};
        textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingTruncatesLastVisibleLine)
                                   attributes:attributes
                                      context:nil].size;
    } else {
        textSize = [self sizeWithFont:textFont
                    constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)
                        lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName: textFont,
                                 NSParagraphStyleAttributeName: paragraph};
    textSize = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
                                  options:(NSStringDrawingUsesLineFragmentOrigin |
                                           NSStringDrawingTruncatesLastVisibleLine)
                               attributes:attributes
                                  context:nil].size;
#endif
    
    return CGSizeMake(ceil(textSize.width), ceil(textSize.height));
}

- (UIImage *)QRcode {
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:self] withSize:200.0f];
    UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:60.0f andGreen:74.0f andBlue:89.0f];
    return customQrcode;
}

#pragma mark - InterpolatedUIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
#pragma mark - QRCodeGenerator
- (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}

- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

- (BOOL)isIncludingEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

- (instancetype)removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([self isEmoji])? @"": substring];
                          }];
    return buffer;
}

- (BOOL)isEmoji {
    if ([self isFuckEmoji]) {
        return YES;
    }
    const unichar high = [self characterAtIndex:0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

- (BOOL)isFuckEmoji {
    NSArray *fuckArray =@[@"⭐",@"㊙️",@"㊗️",@"⬅️",@"⬆️",@"⬇️",@"⤴️",@"⤵️",@"#️⃣",@"0️⃣",@"1️⃣",@"2️⃣",@"3️⃣",@"4️⃣",@"5️⃣",@"6️⃣",@"7️⃣",@"8️⃣",@"9️⃣",@"〰",@"©®",@"〽️",@"‼️",@"⁉️",@"⭕️",@"⬛️",@"⬜️",@"⭕",@"",@"⬆",@"⬇",@"⬅",@"㊙",@"㊗",@"⭕",@"©®",@"⤴",@"⤵",@"〰",@"†",@"⟹",@"ツ",@"ღ",@"©",@"®"];
    BOOL result = NO;
    for(NSString *string in fuckArray){
        if ([self isEqualToString:string]) {
            return YES;
        }
    }
    if ([@"\u2b50\ufe0f" isEqualToString:self]) {
        result = YES;
        
    }
    return result;
}


- (NSString *)removeHTML2:(NSString *)html{
    NSArray *components = [html componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSMutableArray *componentsToKeep = [NSMutableArray array];
    for (int i = 0; i < [components count]; i = i + 2) {
        [componentsToKeep addObject:[components objectAtIndex:i]];
        
    }
    NSString *plainText = [componentsToKeep componentsJoinedByString:@""];
    return plainText;
}

@end
