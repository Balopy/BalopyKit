//
//  UIButton+Balopy.m
//  RunTimeInstance
//
//  Created by 王春龙 on 2018/5/27.
//  Copyright © 2018年 王春龙. All rights reserved.
//

#import "UIButton+Balopy.h"
#import <objc/runtime.h>

@interface UIButton ()

/*! 临时变量 */
@property (nonatomic, assign) NSTimeInterval temp_acceptEventInterval;

@end

@implementation UIButton (Balopy)



+ (void)load {
    
    //系统方法
    SEL originM = @selector(sendAction:to:forEvent:);
    Method beforeMethod = class_getInstanceMethod(self, originM);
    
    //自定义方法
    SEL customM = @selector(bl_sendAction:to:forEvent:);
    Method lastMethod = class_getInstanceMethod(self, customM);
    
    /*! 注意，交换方法分两种情况：
     1. 目标类，实现了父类方法，使用`method_exchangeImplementations()`，
     2. 目标类，没有实现父类方法。使用`class_replaceMethod()`
     
     如果`class_getInstanceMethod`会返回父类的实现，使用`method_exchangeImplementations`可以直接替换父类方法。
     
     如果目标类中的没有实现父类方法，如:[NNString description],如果在NSString类中没有实现`-(NSString *) description`, 使用`class_getInstanceMethod`会得到`NSObject`的`description`，如果调用`method_exchangeImplementations`，会把`NSObject`的方法替换掉,显然不是我们想要的结果。安全的做法，在目标类中增加一个新的实现方法，然后将重写的方法替换为系统(父类)方法,使用`class_addMethod()`判断是否添加成功。，如果添加成功，再把重写的方法替换为原有(父类)的方法.
     */
    //判断
    
    BOOL isExist = class_addMethod(self, originM, method_getImplementation(lastMethod), method_getTypeEncoding(lastMethod));
    
    if (isExist) {
        class_replaceMethod(self, customM, method_getImplementation(beforeMethod), method_getTypeEncoding(beforeMethod));
    } else {
        method_exchangeImplementations(beforeMethod, lastMethod);
    }
}

#pragma mark --- 给增加一个回调属性 ---
static const void *touchUpInside_blockKey = @"touchUpInside_blockKey";

-(void)setTouchUpInsideblock:(BLTouchUpInsideEvent)touchUpInsideblock {
  
    objc_setAssociatedObject(self, touchUpInside_blockKey, touchUpInsideblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //选移除之前的点击方法，防止点击方法一直持有
    [self removeTarget:self action:@selector(touchupInside:) forControlEvents:UIControlEventTouchUpInside];
   
    if (touchUpInsideblock) {
        
        [self addTarget:self action:@selector(touchupInside:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (BLTouchUpInsideEvent) touchUpInsideblock {
    return  objc_getAssociatedObject(self, touchUpInside_blockKey);
}


- (void) touchupInside:(UIButton *)sender {
    
    if (self.touchUpInsideblock) {
        self.touchUpInsideblock (sender);
    }
}

/*!
1. 关联属性, 自定义时间间隔 */
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";

#pragma -- 赋值 --
- (void)setBl_acceptEventInterval:(NSTimeInterval)bl_acceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(bl_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)bl_acceptEventInterval {
   return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

/*! 1. 关联属性, 临时变量 */
static const char *bl_temp_acceptEventInterval = "bl_temp_acceptEventInterval";

- (void)setTemp_acceptEventInterval:(NSTimeInterval)temp_acceptEventInterval {
    objc_setAssociatedObject(self, bl_temp_acceptEventInterval, @(temp_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)temp_acceptEventInterval {
    return [objc_getAssociatedObject(self, bl_temp_acceptEventInterval) doubleValue];
}


/*! 自定义方法，
 1. 记录当前时间戳
 2. 当前时间戳 - 临时变量 < 设定时间 则return
 3. 如果设定值>0, 记录当前时间，再次点击，执行 2
 */
- (void) bl_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    NSTimeInterval date = [NSDate date].timeIntervalSince1970;
    
    if (date - self.temp_acceptEventInterval < self.bl_acceptEventInterval) {
        NSLog(@"时间太短，拒绝");
        
        return;
    }
    
    if (self.bl_acceptEventInterval > 0) {
       
        self.temp_acceptEventInterval = date;
    }
    
    [self bl_sendAction:action to:target forEvent:event];
}

/*! title, 本身是normal状态下的 titleLabel.text，所以在设置时可以直接使用 */
- (void)setBlTitle:(NSString *)blTitle {
    [self setTitle:blTitle forState:UIControlStateNormal];
}

- (NSString *)blTitle {

    return self.titleLabel.text;
}

/*! void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
其中 object 当前对象，
 const void *key， 方法指针地址
 value  值
policy   引用计数
 */
- (void)setBlSelectedTitle:(NSString *)blSelectedTitle {
   //关联值
    objc_setAssociatedObject(self, @selector(blSelectedTitle), blSelectedTitle, OBJC_ASSOCIATION_COPY);
    
    [self setTitle:blSelectedTitle forState:UIControlStateSelected];
}

/*! selectedTitle， 需要关联一个值
 _cmd, 在Objective-C的方法中表示当前方法的selector，
 正如同self表示当前方法调用的对象实例。
 一个是_cmd，当前方法的一个SEL指针。
 一个是self，指向当前对象的一个指针。
 */
- (NSString *)blSelectedTitle {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBlFont:(UIFont *)blFont {
    self.titleLabel.font = blFont;
}

- (UIFont *)blFont {
    return self.titleLabel.font;
}

- (void)setBlImage:(NSString *)blImage {
 
    objc_setAssociatedObject(self, @selector(blImage), blImage, OBJC_ASSOCIATION_COPY);
  
    UIImage *image = [UIImage imageNamed:blImage];
    [self setImage:image forState:UIControlStateNormal];
}

- (NSString *)blImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBlSelectedImage:(NSString *)blSelectedImage {
    
    objc_setAssociatedObject(self, @selector(blSelectedImage), blSelectedImage, OBJC_ASSOCIATION_COPY);
    
    UIImage *image = [UIImage imageNamed:blSelectedImage];
    [self setImage:image forState:UIControlStateSelected];
}

- (NSString *)blSelectedImage {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setBlColor:(UIColor *)blColor {
    
    objc_setAssociatedObject(self, @selector(blColor), blColor, OBJC_ASSOCIATION_RETAIN);
    
    [self setTitleColor:blColor forState:UIControlStateNormal];
}

- (UIColor *)blColor {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setBlSelectedColor:(UIColor *)blSelectedColor {
    
    objc_setAssociatedObject(self, @selector(blSelectedColor), blSelectedColor, OBJC_ASSOCIATION_RETAIN);
    
    [self setTitleColor:blSelectedColor forState:UIControlStateSelected];
}

- (UIColor *)blSelectedColor {
    return objc_getAssociatedObject(self, _cmd);
}




@end
