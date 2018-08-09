//
//  ViewController.m
//  BLKit
//
//  Created by 王春龙 on 2018/7/31.
//  Copyright © 2018年 王春龙. All rights reserved.
//

#import "ViewController.h"
#import "BLDropDownListItem.h"
#import "BLDropDownListView.h"
#import "UIButton+Balopy.h"


@interface ViewController ()<BLDropDownListViewDelegate>


@property (nonatomic, weak) BLDropDownListView *dropListView;

/*! 临时用button，用来改变按钮title */
@property (nonatomic, weak) UIButton *tempButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self setUpTopView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTopView {
    
    NSArray *names = @[@"专业", @"班级", @"排序"];
    
    CGFloat height = 40;
    CGFloat width = CGRectGetWidth(self.view.frame);
    NSUInteger count = names.count;
    
    for (int i = 0; i < count; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(i * (width / count), 80, width/count, height);
        btn.tag = i;
        btn.blFont = [UIFont systemFontOfSize:15];
        btn.blColor = [UIColor darkGrayColor];
        btn.blSelectedColor = [UIColor blueColor];
        btn.blTitle = names[i];
        btn.blImage = @"矩形-29-拷贝";
        btn.blSelectedImage = @"blue_矩形-29";
        [btn buttonTapEvent:^(UIButton *sender) {
            
            [self classThreeBtnClick:sender];
        }];
        
        [self.view addSubview:btn];
    }
}

- (void) classThreeBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    [self removeFromDropViewSuperView];

    if (sender.selected) {
        
        switch (sender.tag) {
            case 0:
                self.dropListView.subjects = [self dealWithDataWithArray:@[@"电子信息工程", @"诸子百家", @"计算机技术", @"通信技术", @"诸子百家", @"计算机技术", @"通信技术", @"诸子百家", @"计算机技术", @"通信技术", @"诸子百家", @"计算机技术", @"通信技术", @"诸子百家", @"计算机技术", @"通信技术"] type:defaultItemType];
                break;
            case 1:
                self.dropListView.subjects = [self dealWithDataWithArray:@[@"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班", @"高一、12班"] type:defaultItemType];
                
                break;
            case 2:
                self.dropListView.subjects = [self dealWithDataWithArray:@[@"价格", @"学习数", @"学习数", @"学习数", @"学习数", @"学习数"] type:defaultItemType];
                
                break;
                
            default:
                break;
        }
    }

    if (_tempButton == sender && sender.selected) {
        
        self.dropListView.hidden = NO;
    } else {
        
        self.dropListView.hidden = NO;
    }
    _tempButton = sender;
}

#pragma mark --- 点空白，隐藏list ---
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *class in self.view.subviews) {
        if ([class isKindOfClass:[UIButton class]]) {
            UIButton *bnt = (UIButton *)class;
            bnt.selected = NO;
        }
    }
    [self removeFromDropViewSuperView];
}


#pragma mark --- 移除list ---
- (void) removeFromDropViewSuperView {
    
    [self.dropListView removeFromSuperview];
    self.dropListView = nil;
}



- (NSArray *) dealWithDataWithArray:(NSArray *)array type:(BLDropDownItemType)type {
    
    NSMutableArray *mutableAr = [NSMutableArray array];
    
    NSDictionary *tempDic = @{ @"id" : @(0),
                               @"name" : @"全部" };
    
    NSMutableArray *tempArray = @[tempDic].mutableCopy;
    [tempArray addObjectsFromArray:array];
    
    [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = obj;
        
        BLDropDownListItem *item = [BLDropDownListItem new];
        
        if ([obj isKindOfClass:NSString.class]) {
            item.ID = idx;
            item.name = obj;
        } else {
           
            if ([dict.allKeys containsObject:@"id"]) {
                item.ID = [[dict objectForKey:@"id"] integerValue];
            } else {
                item.ID = idx;
            }
            
            if ([dict.allKeys containsObject:@"name"]) {
                item.name = [dict objectForKey:@"name"];
            } else {
                item.name = @"默认";
            }
        }
        item.isSelected = (idx == 0);
        item.width = [item.name sizeWithFont:[UIFont systemFontOfSize:15.f]].width + 20;
        item.height = 40;
   
        [mutableAr addObject:item];
    }];
    return mutableAr;
}



- (BLDropDownListView *)dropListView {
    
    if (!_dropListView) {
        
        CGRect frame = CGRectMake(0, 80+40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-(80+40));
        BLDropDownListView *dropListView = [[BLDropDownListView alloc] initWithFrame:frame];
        dropListView.dropDelegate = self;
        dropListView.hidden = YES;
        [self.view addSubview:dropListView];
        _dropListView = dropListView;
    }
    return _dropListView;
}




@end
