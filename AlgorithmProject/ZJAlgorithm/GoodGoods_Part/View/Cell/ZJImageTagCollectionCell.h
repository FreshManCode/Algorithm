//
//  ZJImageTagCollectionCell.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseCollectionViewCell.h"

@class ZJGoodsTableHeadCategoryListModel;

NS_ASSUME_NONNULL_BEGIN

static NSString * const kImageTagCollectionCellID = @"ZJImageTagCollectionCellID";


@interface ZJImageTagCollectionCell : ZJBaseCollectionViewCell

- (void)setGoodsCategoryListsModel:(NSArray <ZJGoodsTableHeadCategoryListModel *> *)lists;

@end

NS_ASSUME_NONNULL_END
