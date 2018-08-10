//
//  UIImageView+MAdd.m
//  Demo_268EDU
//
//  Created by magic on 2018/1/21.
//  Copyright © 2018年 Magic. All rights reserved.
//

#import "UIImageView+MAdd.h"
#import "NNToolHeader.h"
#import <objc/runtime.h>

@interface UIImageView ()

/**
 是否已经被裁圆
 */
@property (nonatomic, assign)  BOOL isCutFinsh;

/**
 被裁剪的 image
 */
@property (nonatomic, strong) UIImage *cornerImage;

@end

@implementation UIImageView (MAdd)
- (void)imageAddCornerRadius:(CGFloat)radius andSize:(CGSize)size{
    //    if (!self.isCutFinsh) {
    //        self.isCutFinsh = YES;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self.image drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //        self.cornerImage = newImage;
    self.image = newImage;
    //    }else{
    //        self.image = self.cornerImage;
    //    }
}

#pragma mark - 懒加载
-(void)setIsCutFinsh:(BOOL)isCutFinsh{
    objc_setAssociatedObject(self, @selector(isCutFinsh), @(isCutFinsh), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)isCutFinsh{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setCornerImage:(UIImage *)cornerImage{
    objc_setAssociatedObject(self, @selector(cornerImage), cornerImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImage *)cornerImage{
    return objc_getAssociatedObject(self, _cmd);
}

@end
