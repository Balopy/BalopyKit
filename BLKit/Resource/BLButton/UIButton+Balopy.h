//
//  UIButton+Balopy.h
//  RunTimeInstance
//
//  Created by 王春龙 on 2018/5/27.
//  Copyright © 2018年 王春龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLTouchUpInsideEvent)(UIButton *sender);


@interface UIButton (Balopy)
/*! 回调 */
- (void) buttonTapEvent:(BLTouchUpInsideEvent)block;

/*! 点击进间隙 */
@property (nonatomic, assign) NSTimeInterval bl_acceptEventInterval;

/*! 按钮的title */
@property (nonatomic, copy) NSString *blTitle;
@property (nonatomic, copy) NSString *blSelectedTitle;

@property (nonatomic, copy) NSString *blImage;
@property (nonatomic, copy) NSString *blSelectedImage;

/*! 按钮字体大小 */
@property (nonatomic, strong) UIFont *blFont;

@property (nonatomic, strong) UIColor *blColor;
@property (nonatomic, strong) UIColor *blSelectedColor;


@end
