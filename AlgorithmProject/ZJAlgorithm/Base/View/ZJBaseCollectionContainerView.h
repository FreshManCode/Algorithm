//
//  ZJBaseCollectionContainerView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  包含Collectionview 的BaseView (用于某些嵌套的CollectionView)

#import <UIKit/UIKit.h>
#import "ZJBaseReuseCollectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class ZJBaseCollectionContainerView;

@protocol ZJBaseCollectionContainerViewDelegate <NSObject>

- (void)collectionContainerView:(ZJBaseCollectionContainerView *)containerView
           didSelectedItemIndex:(NSInteger)index;

@end

@interface ZJBaseCollectionContainerView : UIView
<ZJBaseReuseCollectionViewProtocol,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;
/**只读布局属性,可以修改里面相关配置信息*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/**数据源*/
@property (nonatomic, strong) NSMutableArray  <NSObject *> *datasArray;

@property (nonatomic,weak) id <ZJBaseCollectionContainerViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
