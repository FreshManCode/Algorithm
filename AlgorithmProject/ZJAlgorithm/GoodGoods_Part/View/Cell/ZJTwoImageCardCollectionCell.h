//
//  ZJTwoImageCardCollectionCell.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@class ZJGoodsTableHeadDynamicListsModel;

static NSString * const kCardCollectionCellID = @"ZJTwoImageCardCollectionCellID";


@interface ZJTwoImageCardCollectionCell : ZJBaseCollectionViewCell

- (void)setDynamicListsModel:(NSArray <ZJGoodsTableHeadDynamicListsModel *> *)listsModel;

@end

NS_ASSUME_NONNULL_END
