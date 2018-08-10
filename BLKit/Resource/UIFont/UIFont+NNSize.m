//
//  UIFont+NNSize.m
//  Demo_268EDU
//
//  Created by 刘朋坤 on 2018/7/25.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import "UIFont+NNSize.h"
#import "NNToolHeader.h"
#import <objc/runtime.h>

@implementation UIFont (NNSize)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method oriMethod = class_getClassMethod([self class], @selector(nnCustomSystemFontOfSize:));
        Method cusMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));

        BOOL addSuccess = class_addMethod(self.class, @selector(sendAction:to:forEvent:), method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSuccess) {
            class_replaceMethod(self.class, @selector(nnCustomSystemFontOfSize:), method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        } else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
    });
}

+ (UIFont *)nnCustomSystemFontOfSize:(CGFloat)fontSize {
    UIFont *newFont = nil;
    if ([[UIScreen mainScreen] bounds].size.height < 667) {
        newFont = [UIFont nnCustomSystemFontOfSize:fontSize * 0.9];
    } else {
        newFont = [UIFont nnCustomSystemFontOfSize:fontSize];
    }
    return newFont;
}

@end
