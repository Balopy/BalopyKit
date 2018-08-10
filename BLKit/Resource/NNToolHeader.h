//
//  NNToolHeader.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#ifndef NNToolHeader_h
#define NNToolHeader_h

//#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define NNScreen_width [[UIScreen mainScreen] bounds].size.width

/** @enum ShakeDirection
 *
 * Enum that specifies the direction of the shake
 */
typedef NS_ENUM(NSInteger, ShakeDirection) {
    /** Shake left and right */
    ShakeDirectionHorizontal,
    /** Shake up and down */
    ShakeDirectionVertical,
    /** Shake rotation */
    ShakeDirectionRotation
};

#endif /* NNToolHeader_h */
