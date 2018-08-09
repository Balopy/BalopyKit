//
//  BLDropDownListItem.h
//  268EDU_Demo
//
//  Created by 王春龙 on 2018/7/31.
//  Copyright © 2018年 edu268. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    defaultItemType = 0,
    letterChangeType,
    imageChangeType
    
}BLDropDownItemType;

@interface BLDropDownListItem : NSObject

@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BLDropDownItemType type;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

@property (nonatomic, assign) BOOL isSelected;


@end
