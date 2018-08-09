//
//  BLKit.m
//  268EDU_Demo
//
//  Created by 王春龙 on 2018/7/31.
//  Copyright © 2018年 edu268. All rights reserved.
//

#import "BLDropDownListView.h"
#import "BLDropDownCollectionCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "BLDropDownListItem.h"


@interface BLDropDownListView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

@end


@implementation BLDropDownListView

static NSString *reuseIdentifier = @"dropViewCellId";
CGFloat cellLeftRightGap = 8;
CGFloat cellTopBtmGap = 8;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



- (void)setSubjects:(NSArray *)subjects {
    _subjects = subjects;
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
#pragma mark ---- section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark ---- item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.subjects.count;
}

#pragma mark ----  The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    /// 重用cell
    BLDropDownCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  
    cell.model = self.subjects[indexPath.row];
    return cell;
}


#pragma mark ---- 定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BLDropDownListItem *model = self.subjects[indexPath.row];

    return CGSizeMake(model.width, model.height);
}

#pragma mark ---- 选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    for (BLDropDownListItem *tmp in self.subjects) {
        tmp.isSelected = NO;
    }
    
    BLDropDownListItem *model = self.subjects[indexPath.row];
    model.isSelected = !model.isSelected;
    
    if (model.type == letterChangeType) {
        
        if (model.isSelected) {
            
            model.name = @"价格↑";
            model.ID = 3;
        } else {
            
            model.name = @"价格↓";
            model.ID = 5;
        }
    }
    
    if ([self.dropDelegate respondsToSelector:@selector(didSelectedForSub:)]) {
        [self.dropDelegate didSelectedForSub:model];
    }
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
    [self.collectionView reloadSections:indexSet];
    
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewLeftAlignedLayout *flowLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
        flowLayout.minimumLineSpacing = cellLeftRightGap;
        flowLayout.minimumInteritemSpacing = cellTopBtmGap;
        flowLayout.sectionInset = UIEdgeInsetsMake(cellTopBtmGap, cellLeftRightGap, cellTopBtmGap, cellLeftRightGap);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        
        CGFloat tmpWidth = 0.0;//单行宽
        CGFloat height = 40 + cellTopBtmGap*2;// 总高 + 上下边距

        CGFloat width = CGRectGetWidth(self.frame) - 2*cellLeftRightGap;//宽 = frame.w - 2*5
        
        for (int i = 0; i < self.subjects.count; i++) {
            
            BLDropDownListItem *model = self.subjects[i];
            
            tmpWidth += (model.width + cellLeftRightGap);//item 宽 + 间距
            
            if (tmpWidth > width) {
                tmpWidth = 0.0;
                height += (model.height + cellTopBtmGap);//行高 + 间距
            }
        }
        
        if (height > CGRectGetHeight(self.frame)-2*cellTopBtmGap) {
            
            height = CGRectGetHeight(self.frame);
        }
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), height) collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];

        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        
        [collectionView registerClass:[BLDropDownCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
