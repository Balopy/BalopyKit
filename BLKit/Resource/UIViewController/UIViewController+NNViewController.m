//
//  UIViewController+NNViewController.m
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import "UIViewController+NNViewController.h"

@implementation UIViewController (NNViewController)

/** 当前视图控制器 */
+ (UIViewController *)currentViewController {
    UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    return [UIViewController findBestViewController:viewController];
}

/** 当前导航控制器 */
+ (UINavigationController *)currentNavigatonController {
    
    UIViewController * currentViewController =  [UIViewController currentViewController];
    
    return currentViewController.navigationController;
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.viewControllers.lastObject];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.topViewController];
        } else {
            return vc;
        }
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0) {
            return [self findBestViewController:svc.selectedViewController];
        } else {
            return vc;
        }
    } else {
        return vc;
    }
}

@end
