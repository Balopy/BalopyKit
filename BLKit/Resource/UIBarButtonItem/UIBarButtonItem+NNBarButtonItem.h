//
//  UIBarButtonItem+NNBarButtonItem.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NNBarButtonItem)

/** 快速创建导航栏按钮 */
+ (instancetype _Nullable )nn_barButtonItemWithTitle:(NSString *_Nullable)title
                                           imageName:(NSString *_Nullable)imageName
                                              target:(nullable id)target
                                              action:(nonnull SEL)action
                                            fontSize:(CGFloat)fontSize
                                    titleNormalColor:(UIColor *_Nullable)normalColor
                               titleHighlightedColor:(UIColor *_Nullable)highlightedColor;

@end
