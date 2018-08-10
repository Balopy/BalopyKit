//
//  UITabBarController+NNTabBarController.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (NNTabBarController)

@property (nonatomic,getter=isTabBarHidden,readonly) BOOL tabBarHidden ;


/**
 设置Tabbar隐藏
 
 @param hidden 是否隐藏
 @param animated 是否有动画
 @param completion 返回回调
 */
- (void)setTabBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion;

@end
