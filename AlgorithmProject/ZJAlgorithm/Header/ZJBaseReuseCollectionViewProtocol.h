//
//  ZJBaseReuseCollectionViewProtocol.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJBaseReuseCollectionViewProtocol <NSObject>

/**
 注册重用的Cell
 
 @param collectionView collectionView
 */
- (void)zj_registercollectionViewCell:(UICollectionView *)collectionView;

/**
 返回 CollectionView的 headerView 的Size
 @param collectionView collectionview
 @param collectionViewLayout collectionViewLayout
 @param section section
 @return headerView 的Size
 */
- (CGSize)zj_collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     sizeForHeaderInSection:(NSInteger)section;


/**
 返回 CollectionView的 footerView 的Size
 @param collectionView collectionview
 @param collectionViewLayout collectionViewLayout
 @param section section
 @return footerView 的Size
 */
- (CGSize)zj_collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     sizeForFooterInSection:(NSInteger)section;


/**
 返回CollectionView 的 headerView

 @param collectionView collectionView
 @param indexPath indexPath
 @return headerView 实例
 */
- (UICollectionReusableView *)zj_collectionViewHeaderView:(UICollectionView *)collectionView
                                              atIndexPath:(NSIndexPath *)indexPath;


/**
 返回CollectionView 的 footerView
 
 @param collectionView collectionView
 @param indexPath indexPath
 @return footerView 实例
 */
- (UICollectionReusableView *)zj_collectionViewFooterView:(UICollectionView *)collectionView
                                              atIndexPath:(NSIndexPath *)indexPath;

/**
 section 数量 默认为1
 
 @param collectionView collectionView
 @return 数量
 */
- (NSInteger)zj_numberOfSectionsInCollectionView:(UICollectionView*)collectionView;


/**
 每个section 中的 item数量
 
 @param collectionView collectionView
 @param section section
 @return 数量
 */
- (NSInteger)zj_collectionView:(UICollectionView *)collectionView
        numberOfItemsInSection:(NSInteger)section;




/**
 每个Section 的 UIEdgeInsets

 @param collectionView collectionView
 @param collectionViewLayout collectionViewLayout
 @param section section
 @return UIEdgeInsets 实例
 */
- (UIEdgeInsets)zj_collectionView:(UICollectionView *)collectionView
                           layout:(UICollectionViewLayout *)collectionViewLayout
           insetForSectionAtIndex:(NSInteger)section;


/**
 根据ID 重用cell
 
 @param collectionView collectionView
 @param indexPath indexPath
 @return cell
 */
- (UICollectionViewCell *)zj_collectionView:(UICollectionView *)collectionView
                                  indexPath:(NSIndexPath *)indexPath;


/**
 返回对应的尺寸
 
 @param collectionView UICollectionView
 @param collectionViewLayout  collectionViewLayout
 @param indexPath indexPath
 @return cgsize
 */
- (CGSize)zj_collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 对应的Collectionview 配置
 
 @return 配置
 */
- (UICollectionViewLayout *)zj_collectionViewFlowLayout;

/**
 即将加载相应的Cell (用来做自动下一页加载,防止多次请求)
 
 @param collectionView collectionView
 @param cell cell
 @param indexPath indexPath
 */
- (void)zj_collectionView:(UICollectionView *)collectionView
          willDisplayCell:(UICollectionViewCell *)cell
       forItemAtIndexPath:(NSIndexPath *)indexPath;


/**加载更多数据*/
- (void)zj_loadMoreData;

/**
 scrollview 将要停止滑动
 
 @param scrollView scrollView
 */
- (void)zj_collectionViewWillEndScroll:(UIScrollView *)scrollView;


@end

NS_ASSUME_NONNULL_END
