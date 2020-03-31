//
//  ZJHorizontalCollectionContainerView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/30.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHorizontalCollectionContainerView.h"
#import "ZJHotTagImageCollectionCell.h"
#import "ZJDiscoverlistItemModel.h"
#import "ZJGoodsTableHeadResModel.h"


@interface ZJHorizontalCollectionContainerView ()

@property (nonatomic, strong) NSMutableArray <ZJGoodsTableHeadCategoryListModel *> *datasArray;

@end

@implementation ZJHorizontalCollectionContainerView
@dynamic datasArray;


static NSString * const kCellID = @"ZJHotTagImageCollectionCell";



- (void)zj_registercollectionViewCell:(UICollectionView *)collectionView {
    [collectionView registerClass:[ZJHotTagImageCollectionCell class] forCellWithReuseIdentifier:kCellID];
}

- (CGSize)zj_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80.f, 70.f);
}

- (void)setCategoryListsModel:(NSArray <ZJGoodsTableHeadCategoryListModel *> *)lists {
    [self.datasArray removeAllObjects];
    [self.datasArray addObjectsFromArray:lists];
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)zj_collectionView:(UICollectionView *)collectionView
                                  indexPath:(NSIndexPath *)indexPath {
    ZJHotTagImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    [cell setGoodsCategoryModel:self.datasArray[indexPath.row]];
    return cell;
}





@end
