//
//  ZJHomeLoadImageCell.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class ZJDiscoverlistItemModel;

@interface ZJHomeLoadImageCell : ZJBaseCollectionViewCell

- (void)setListItemModel:(ZJDiscoverlistItemModel *)itemModel
          collectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
