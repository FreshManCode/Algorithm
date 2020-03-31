//
//  ZJBaseCollectionContainerView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseCollectionContainerView.h"
#import <Masonry.h>


@implementation ZJBaseCollectionContainerView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        [self zj_registercollectionViewCell:self.collectionView];
    }
    return self;
}



// MARK: -ZJBaseReuseCollectionViewProtocol
/**
 注册重用的Cell
 
 @param collectionView collectionView
 */
- (void)zj_registercollectionViewCell:(UICollectionView *)collectionView {
    
}

- (UICollectionReusableView *)zj_collectionViewFooterView:(UICollectionView *)collectionView
                                              atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UICollectionReusableView *)zj_collectionViewHeaderView:(UICollectionView *)collectionView
                                              atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGSize)zj_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)zj_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

/**
 section 数量 默认为1
 
 @param collectionView collectionView
 @return 数量
 */
- (NSInteger)zj_numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}


/**
 每个section 中的 item数量
 
 @param collectionView collectionView
 @param section section
 @return 数量
 */
- (NSInteger)zj_collectionView:(UICollectionView *)collectionView
        numberOfItemsInSection:(NSInteger)section {
    return self.datasArray.count;
}

/**
 根据ID 重用cell
 
 @param collectionView collectionView
 @param indexPath indexPath
 @return cell
 */
- (UICollectionViewCell *)zj_collectionView:(UICollectionView *)collectionView
                                  indexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

/**
 对应的Collectionview 配置 (子类需要自行实现该配置)
 
 @return 配置
 */
- (UICollectionViewLayout *)zj_collectionViewFlowLayout {
    return self.flowLayout;
}

- (CGSize)zj_collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeZero;
}
- (UIEdgeInsets)zj_collectionView:(UICollectionView *)collectionView
                           layout:(UICollectionViewLayout *)collectionViewLayout
           insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self zj_collectionView:collectionView layout:collectionViewLayout sizeForHeaderInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return [self zj_collectionView:collectionView layout:collectionViewLayout sizeForFooterInSection:section];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        return [self zj_collectionViewHeaderView:collectionView atIndexPath:indexPath];
    }
    return [self zj_collectionViewFooterView:collectionView atIndexPath:indexPath];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return [self zj_collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self zj_numberOfSectionsInCollectionView:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self zj_collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self zj_collectionView:collectionView   indexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self zj_collectionView:collectionView
                            layout:collectionViewLayout
            sizeForItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJNSLOG(@"点击事件:%ld",indexPath.row);
    if (_delegate && [_delegate respondsToSelector:@selector(collectionContainerView:didSelectedItemIndex:)]) {
        [_delegate collectionContainerView:self didSelectedItemIndex:indexPath.row];
    }
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:[self zj_collectionViewFlowLayout]];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces    = true;
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
    }
    return _collectionView;
}


- (UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing      = 5.f;
        flowLayout.minimumInteritemSpacing = 5.f;
        flowLayout.sectionInset      = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection   = UICollectionViewScrollDirectionHorizontal;
        _flowLayout = flowLayout;
    }
    return _flowLayout;
}

- (NSMutableArray *)datasArray{
    if(!_datasArray){
        _datasArray = [NSMutableArray new];
    }
    return _datasArray;
}


@end
