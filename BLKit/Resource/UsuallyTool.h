//
//  UsuallyTool.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#ifndef UsuallyTool_h
#define UsuallyTool_h

#import "NSObject+MAdd.h"
#import "NSObject+NNRuntime.h"

#import "NSString+CZ.h"

#import "NSArray+NNExtension.h"

#import "UIFont+NNSize.h"

#import "UIImage+CZ.h"

#import "UIImageView+MAdd.h"

#import "UIView+Shake.h"
#import "UIView+NNView.h"

#import "UIBarButtonItem+NNBarButtonItem.h"

#import "UIColor+NNColor.h"

#import "UILabel+NNLabel.h"

#import "UINavigationController+NNNavigationController.h"

#import "UIViewController+NNViewController.h"

#import "UITextField+NNTextField.h"

#import "UIDevice+NNDevice.h"

#import "UITabBarController+NNTabBarController.h"


/** 字符串是否为空 */
#define kIsStringEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

/** 数组是否为空 */
#define kIsArrayEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

/** 字典是否为空 */
#define kIsDictEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

#endif /* UsuallyTool_h */
