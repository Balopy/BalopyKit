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
#import "UIButton+Balopy.h"
#import "BLScrollLabel.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "BLGeneralControl.h"
//字符串是否为空
#define BLStringIsEmpty(str) (([str isKindOfClass:[NSString class]] && str && [str length]) ? NO : YES)
//数组是否为空
#define BLArrayIsEmpty(array) ((array && array.count) ? NO : YES)
//字典是否为空
#define BLDictIsEmpty(dic) ((dic && dic.allKeys) ? NO : YES)


#endif /* UsuallyTool_h */
