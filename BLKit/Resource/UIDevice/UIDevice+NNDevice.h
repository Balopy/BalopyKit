//
//  UIDevice+NNDevice.h
//  UsuallyTool
//
//  Created by 刘朋坤 on 2018/8/2.
//  Copyright © 2018年 刘朋坤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, UIDeviceNetType) {
    UIDeviceNetTypeUnknow,
    UIDeviceNetTypeNot,
    UIDeviceNetType2G,
    UIDeviceNetType3G,
    UIDeviceNetType4G,
    UIDeviceNetTypeWIFI
};

@interface UIDevice (NNDevice)
/** 硬盘空间 */
@property (nonatomic,readonly) int64_t diskSpace;
/** 硬盘剩余空间 */
@property (nonatomic,readonly) int64_t diskSpaceFree;
/** 硬盘使用空间 */
@property (nonatomic,readonly) int64_t diskSpaceUsed;
/** 内存空间 */
@property (nonatomic, readonly) int64_t memoryTotal;
/** 内存使用空间 */
@property (nonatomic, readonly) int64_t memoryUsed;
/** 内存剩余空间 */
@property (nonatomic, readonly) int64_t memoryFree;
/** 内存活动空间 */
@property (nonatomic, readonly) int64_t memoryActive;
/** 内存非活动时间 */
@property (nonatomic, readonly) int64_t memoryInactive;
/** 内存压缩空间 */
@property (nonatomic, readonly) int64_t memoryWired;
@property (nonatomic, readonly) int64_t memoryPurgable;

/** MAC地址 */
@property (nonatomic,readonly) NSString *macAddress ;
/** 是否为WIFI */
@property (nonatomic,readonly) NSString *ipAddressWIFI ;
/** 是否为蜂窝煤网络 */
@property (nonatomic,readonly) NSString *ipAddressCell ;
/** 网络类型 */
@property (nonatomic,readonly) UIDeviceNetType networkType ;

@end
