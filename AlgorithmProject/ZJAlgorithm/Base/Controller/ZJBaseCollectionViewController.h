//
//  ZJBaseCollectionViewController.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJBaseReuseCollectionViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZJFlowLayoutType) {
    ZJFlowLayoutUnEqual = 0, //不规则的 瀑布流 (同一行高度不同)
    ZJFlowLayoutEqual   = 1, //规则的瀑布流  (同一行高度相同)
};

typedef void (^ZJLoadMoreAction)(void);

@interface ZJBaseCollectionViewController : ZJBaseViewController
<ZJBaseReuseCollectionViewProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**测试用例,后面可删除*/
@property (nonatomic, copy) NSString *name;


@property (nonatomic, strong) UICollectionView *collectionView;

/**FlowLayout 规则,默认不规则的瀑布流*/
@property (nonatomic, assign) ZJFlowLayoutType flowLayoutType;


/**数据源*/
@property (nonatomic, strong) NSMutableDictionary  <NSNumber *,NSObject *> *datasDic;

/**数据源*/
@property (nonatomic, strong) NSMutableArray  <NSObject *> *datasArray;

/**默认的Layout*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

/**默认为15 距离本次数据源还有多少结束,就触发请求更多操作 比如一次40条数据,加载到>= 40-nextGap 时触发加载下一页*/
@property (nonatomic, assign) NSInteger nextGap;

/**是否重置 Collectionview 距离顶部的距离 (默认为导航栏高度)*/
@property (nonatomic, assign) BOOL resetTopOffset;


/**
 指定 FlowLayout 初始化方式

 @param layoutType FlowLayout
 @return 实例
 */
- (instancetype)initWithFlowLayout:(ZJFlowLayoutType)layoutType;


/**
 指定 FlowLayout 初始化方式
 
 @param layoutType FlowLayout
 @return 实例
 */
+ (instancetype)initWithFlowLayout:(ZJFlowLayoutType)layoutType;

/**删除下拉刷新功能*/
- (void)zj_uninstallRefreshHeader;
/**删除加载更多功能*/
- (void)zj_uninstallRefreshFooter;

/**下拉刷新*/
- (void)zj_refreshAction;

/**重写刷新数据(防止在自动加载下一页数据时,有bug)*/
- (void)zj_readyReloadData:(ZJLoadMoreAction)loadMore;


/**停止加载*/
- (void)zj_endingLoading;



@end

NS_ASSUME_NONNULL_END
