//
//  ZJHorizontalCollectionContainerView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/30.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  水平方向左右滑动的Collectionview (放图片 + 文本)

#import <UIKit/UIKit.h>
#import "ZJBaseCollectionContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@class ZJDiscoverlistItemModel;
@class ZJGoodsTableHeadCategoryListModel;

@interface ZJHorizontalCollectionContainerView : ZJBaseCollectionContainerView
/**是否允许左右滑动,默认为No*/
@property (nonatomic, assign) BOOL enableScroll;

/**View高度,默认为60 pt*/
@property (nonatomic, assign) CGFloat ContainerH;



- (void)setCategoryListsModel:(NSArray <ZJGoodsTableHeadCategoryListModel *> *)lists;


@end

NS_ASSUME_NONNULL_END
