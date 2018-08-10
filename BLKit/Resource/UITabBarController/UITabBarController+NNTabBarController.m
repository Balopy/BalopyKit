//
//  UITabBarController+NNTabBarController.m
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import "UITabBarController+NNTabBarController.h"

@implementation UITabBarController (NNTabBarController)

- (BOOL)isTabBarHidden {
    return [[self tabBar] frame].origin.y >= CGRectGetMaxY([[self view] frame]);
}

- (void)setTabBarHidden:(BOOL)hidden
               animated:(BOOL)animated
             completion:(void (^)(BOOL finished))completion {
    
    if ([self isTabBarHidden] == hidden)
        return (completion) ? completion(YES) : nil;
    
    CGRect frame = [[self tabBar] frame];
    frame.origin.y = (hidden) ? [[self view] frame].size.height :[[self view] frame].size.height - frame.size.height;
    [UIView animateWithDuration:((animated) ? 0.3 : 0.0)
                     animations:^{
                         [[self tabBar] setFrame:frame];
                     } completion:completion];
}

@end
