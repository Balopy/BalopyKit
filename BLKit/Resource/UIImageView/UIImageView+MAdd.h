//
//  UIImageView+MAdd.h
//  Demo_268EDU
//
//  Created by magic on 2018/1/21.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MAdd)

/**
 图片裁剪

 @param radius 裁剪弧度
 @param size 图片大小
 */
- (void)imageAddCornerRadius:(CGFloat)radius andSize:(CGSize)size;

@end
