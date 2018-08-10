//
//  UIView+NNView.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureActionBlock)(UITapGestureRecognizer *gestureRecoginzer);

@interface UIView (NNView)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 添加tap手势 */
- (void)nn_addTapActionWithBlock:(GestureActionBlock)block;
/** 添加长按手势 */
- (void)nn_addLongPressActionWithBlock:(GestureActionBlock)block;

@end
