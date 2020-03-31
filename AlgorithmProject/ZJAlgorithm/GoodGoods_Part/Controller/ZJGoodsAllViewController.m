//
//  ZJGoodsAllViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJGoodsAllViewController.h"
#import "ZJHomeGoodsViewController.h"
#import "ZJSortHeaderView.h"
#import "ZJDiscoverlistItemModel.h"
#import "ZJHomeLoadImageCell.h"
#import "ZJBannerLoopCell.h"
#import "ZJCycleLoopCollectionViewCell.h"
#import "ZJImageTagCollectionCell.h"
#import "ZJTwoImageCardCollectionCell.h"
#import "ZJHotSortSelectedView.h"
#import "ZJConstHeader.h"
#import "ZJGoodsTableHeadResModel.h"
#import "ZJReadLocalFileManager.h"

#define kMaxWidth  floorf((ZJScreenWidth - 30 )/2.0)

@interface ZJGoodsAllViewController ()
<ZJBaseViewControllerDelegate,ZJSortHeaderViewDelegate,ZJBaseTableViewContainerViewDelegate,ZJCycleLoopCollectionViewCellDelegate>
@property (nonatomic, strong) NSMutableArray <NSString *> *imageURLS;
@property (nonatomic, strong) ZJSortHeaderView *headerSortView;

@property (nonatomic, strong) NSMutableArray <ZJDiscoverlistItemModel *> *tempArray;
@property (nonatomic, strong) NSMutableArray <ZJDiscoverlistItemModel *>*datasArray;
/**记录Headerview 停留时的Coollectionview 临界滑动偏移量*/
@property (nonatomic, assign) CGFloat headerViewStopOffset;
@property (nonatomic, strong) ZJHotSortSelectedView *hotSelectedView;

@property (nonatomic, strong) NSMutableArray <NSString *> *hotTags;
/**是否点击分类/排序View 触发Collectionview 偏移*/
@property (nonatomic, assign) BOOL sortViewTouch;

@property (nonatomic, strong) ZJGoodsTableHeadResModel *headResModel;

@property (nonatomic, strong) ZJReadLocalFileManager *headFile;
@property (nonatomic, strong) ZJReadLocalFileManager *contentFile;


@end

@implementation ZJGoodsAllViewController

@dynamic datasArray;


static NSString * const kLoadImageCellID = @"ZJHomeLoadImageCellID";
static NSString * const kHeaderViewID    = @"UICollectionReusableViewID";
static CGFloat const kSortHeaderHeight   = 40.f;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setResetTopOffset:true];
    [self zj_uninstallRefreshFooter];
}

- (void)zj_registercollectionViewCell:(UICollectionView *)collectionView {
    [collectionView registerClass:[ZJImageTagCollectionCell class]
       forCellWithReuseIdentifier:kImageTagCollectionCellID];
    [collectionView registerClass:[ZJCycleLoopCollectionViewCell class] forCellWithReuseIdentifier:kCycyleCollectionCellID];
    [collectionView registerClass:[ZJHomeLoadImageCell class]
       forCellWithReuseIdentifier:kLoadImageCellID];
    [collectionView registerClass:[ZJTwoImageCardCollectionCell class] forCellWithReuseIdentifier:kCardCollectionCellID];
    
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:kHeaderViewID];
}

- (void)zj_autoRefresh {
    [self.headFile readFileName:@"GoodsHeadTable"
                         format:@"json"
                         result:^(id  data, NSError * error) {
                             if (data) {
                                 [self handleWithHeadRessult:data];
                                 
                             }
                         }];
    
    [self.contentFile readFileName:@"TestImage"
                            format:@"json"
                            result:^(id  data, NSError *  error) {
                                if (data) {
                                    [self handleWithContentRessult:data];
                                }
                            }];
}

/**下拉刷新*/
- (void)zj_refreshAction {
    [self zj_autoRefresh];
}

- (void)handleWithHeadRessult:(NSDictionary *)result {
    self.headResModel = [ZJGoodsTableHeadResModel modelWithJSON:result[@"data"]];
    [self setRefreshed:true];
    [self setRefreshing:false];
    [self zj_endingLoading];
    [self.collectionView reloadData];
}

- (void)handleWithContentRessult:(NSArray *)result {
    if ([result isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in result) {
            ZJDiscoverlistItemModel *model = [ZJDiscoverlistItemModel modelWithDictionary:dic];
            [self.tempArray addObject:model];
        }
        [self.datasArray addObjectsFromArray:[self getDataCount:50]];
    }
    [self convertSortViewFrame];
    [self.collectionView reloadData];
}


- (void)zj_loadMoreData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.datasArray addObjectsFromArray:[self getDataCount:30]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self zj_readyReloadData:^{
                [self.collectionView reloadData];
            }];
        });
    });
}

// MARK: - 弹出搜索/排序View ,并且是否有搜索框
- (void)showSortOrFilterViewWithSearchBar:(BOOL)aSearchBar {
    if (aSearchBar) {
        [self setSortViewTouch:true];
        [UIView animateWithDuration:0.35f animations:^{
            CGPoint contentOffset = self.collectionView.contentOffset;
            contentOffset.y = self.headerViewStopOffset;
            [self.collectionView setContentOffset:contentOffset];
        } completion:^(BOOL finished) {
            [self.hotSelectedView showInView:self.view];
            [self setSortViewTouch:false];
        }];
    }
    else {
        [self.hotSelectedView showInView:self.view];
    }
}

- (NSInteger)zj_numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (!self.headResModel) {
        return 0;
    }
    return 2;
}

- (CGSize)zj_collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(ZJScreenWidth, kSortHeaderHeight);
}

- (UICollectionReusableView *)zj_collectionViewHeaderView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewID forIndexPath:indexPath];
    [headerView addSubview:self.headerSortView];
    return headerView;
}


- (UICollectionViewCell *)zj_collectionView:(UICollectionView *)collectionView
                                  indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            ZJCycleLoopCollectionViewCell *cycleCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCycyleCollectionCellID forIndexPath:indexPath];
            [cycleCell setDelegate:self];
            [cycleCell setBannerModelLists:self.headResModel.banner_list];
            return cycleCell;
        }
        else if (indexPath.row == 1) {
            ZJImageTagCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kImageTagCollectionCellID forIndexPath:indexPath];
            [cell setGoodsCategoryListsModel:self.headResModel.category_list];
            return cell;
        }
        else if (indexPath.row == 2) {
            ZJTwoImageCardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCardCollectionCellID forIndexPath:indexPath];
            [cell setDynamicListsModel:self.headResModel.n_dynamic_list];
            return cell;
        }
    }
    ZJHomeLoadImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLoadImageCellID
                                                                          forIndexPath:indexPath];
    [cell setListItemModel:self.datasArray[indexPath.row] collectionView:collectionView];
    
    return cell;
}

- (NSInteger)zj_collectionView:(UICollectionView *)collectionView
        numberOfItemsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 3;
    }
    return self.datasArray.count;
}

- (CGSize)zj_collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return CGSizeMake(ceil(ZJScreenWidth - 20), 140.f);
        }
        else if (indexPath.row == 1) {
            return CGSizeMake(ceil(ZJScreenWidth - 20), 80.f);
        }
        else if (indexPath.row == 2) {
            return CGSizeMake(ceil(ZJScreenWidth - 20), 80.f);
        }
    }
    return CGSizeMake(kMaxWidth, 170.f) ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s--%ld",__func__,indexPath.row);
}


// MARK: - ZJCycleLoopCollectionViewCellDelegate

- (void)cycyleLoopCell:(ZJCycleLoopCollectionViewCell *)loopCell
         didClickIndex:(NSInteger)index {
    ZJNSLOG(@"didClickIndex:%ld",index);
}


// MARK: -ZJBaseViewControllerDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //  把滑动事件抛出去,让主Controller 处理对应的逻辑
    if (_DelegateFlags.ZJDidScrollDelegateTags && !_sortViewTouch) {
        [self.topDelegate baseScrollViewDidScroll:scrollView];
    }
}

// MARK: - ZJSortHeaderViewDelegate
- (void)sortView:(ZJSortHeaderView *)sortView
   didClickIndex:(NSInteger)clickIndex
          isOpen:(BOOL)isOpen{
    if (clickIndex == 0) {
        if (isOpen) {
            if (ceil(self.collectionView.contentOffset.y) <= self.headerViewStopOffset ) {
                [self showSortOrFilterViewWithSearchBar:true];
            }
            else {
                [self showSortOrFilterViewWithSearchBar:false];
            }
        } else {
            [self.hotSelectedView dismissView];
        }
    }
}

// MARK: - ZJBaseTableViewContainerViewDelegate
- (void)tableContainerView:(ZJBaseTableViewContainerView *)containerView
             didClickIndex:(NSInteger)index {
    [self.headerSortView updateLeftTitle:self.hotTags[index]];
}

- (void)tableContainerViewDidDissmiss:(ZJBaseTableViewContainerView *)containerView {
    [self.headerSortView resetDefaultState];
}

- (void)convertSortViewFrame {
    CGRect sortViewRect = [self.headerSortView convertRect:self.headerSortView.frame toView:self.collectionView];
    self.headerViewStopOffset = sortViewRect.origin.y;
}


- (NSMutableArray *)imageURLS{
    if(!_imageURLS){
        _imageURLS = [NSMutableArray new];
        [_imageURLS addObject:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"];
        [_imageURLS addObject:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"];
        [_imageURLS addObject:@"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    }
    return _imageURLS;
}


- (ZJSortHeaderView *)headerSortView{
    if(!_headerSortView){
        _headerSortView = [[ZJSortHeaderView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth, kSortHeaderHeight)];
        [_headerSortView setDelegate:self];
        [_headerSortView setBackgroundColor:[UIColor whiteColor]];
    }
    return _headerSortView;
}


- (NSMutableArray *)tempArray{
    if(!_tempArray){
        _tempArray = [NSMutableArray new];
    }
    return _tempArray;
}


- (NSMutableArray *)hotTags{
    if(!_hotTags){
        _hotTags = [[NSMutableArray alloc] initWithCapacity:10];
        [_hotTags addObject:@"热门排序"];
        [_hotTags addObject:@"最新降价"];
        [_hotTags addObject:@"高价求购"];
        [_hotTags addObject:@"最新上架"];
        [_hotTags addObject:@"销量排序"];
        [_hotTags addObject:@"价格从高到低"];
    }
    return _hotTags;
}


- (ZJHotSortSelectedView *)hotSelectedView{
    if(!_hotSelectedView){
        CGRect frame = CGRectMake(0, kSortHeaderHeight, ZJScreenWidth, ZJScreenHeight - kSortHeaderHeight);
        _hotSelectedView = [[ZJHotSortSelectedView alloc] initWithFrame:frame];
        [_hotSelectedView setBackgroundColor:ZJColorWithHexA(0x000000, 0.5)];
        [_hotSelectedView setDatasArray:self.hotTags];
        [_hotSelectedView setDelegate:self];
    }
    return _hotSelectedView;
}

- (NSArray *)getDataCount:(NSInteger)count {
    if (count >= self.tempArray.count) {
        return self.tempArray.copy;
    }
    else {
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:count];
        [self.tempArray enumerateObjectsUsingBlock:^(ZJDiscoverlistItemModel *  obj, NSUInteger idx, BOOL *stop) {
            if (idx < count) {
                [tempArray addObject:obj];
            }
        }];
        return tempArray.copy;
    }
}


- (ZJReadLocalFileManager *)headFile{
    if(!_headFile){
        _headFile = [ZJReadLocalFileManager new];
    }
    return _headFile;
}


- (ZJReadLocalFileManager *)contentFile{
    if(!_contentFile){
        _contentFile = [ZJReadLocalFileManager new];
    }
    return _contentFile;
}



@end
