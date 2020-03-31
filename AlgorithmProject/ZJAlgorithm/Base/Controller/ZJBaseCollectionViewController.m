//
//  ZJBaseCollectionViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseCollectionViewController.h"
#import <MJRefresh.h>
#import "ZMWaterFlowLayout.h"

@interface ZJBaseCollectionViewController ()

/**自动刷新更多数据的回调,注意:用完就销毁,防止重复添加(刷新)数据*/
@property (nonatomic, copy,nullable) ZJLoadMoreAction  LoadMoreAction;
/**是否正在加载中*/
@property (nonatomic, assign,getter=isLoading)   BOOL loading;

/**是否正在滑动*/
@property (nonatomic, assign,getter=isScrolling) BOOL scrolling;


@end

@implementation ZJBaseCollectionViewController


/**
 指定 FlowLayout 初始化方式
 
 @param layoutType FlowLayout
 @return 实例
 */
+ (instancetype)initWithFlowLayout:(ZJFlowLayoutType)layoutType {
    return [[self alloc] initWithFlowLayout:layoutType];
}

/**
 指定 FlowLayout 初始化方式
 
 @param layoutType FlowLayout
 @return 实例
 */
- (instancetype)initWithFlowLayout:(ZJFlowLayoutType)layoutType {
    if (self = [super init]) {
        self.flowLayoutType = layoutType;
    }
    return self;
}


- (id)init {
    if (self = [super init]) {
        self.flowLayoutType = ZJFlowLayoutUnEqual;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_registerCollectionViewSource];
    [self.view addSubview:self.collectionView];
    [self p_initDefaultData];
}

- (void)p_registerCollectionViewSource {
     [self zj_registercollectionViewCell:self.collectionView];
}

- (void)p_initDefaultData {
    [self setNextGap:15];
    [self zj_installLoadMoreFooter];
    [self zj_installRefreshHeader];
}

- (void)zj_installLoadMoreFooter {
    __weak typeof(self) weakSelf     = self;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf zj_loadMoreData];
    }];
    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStatePulling];
    self.collectionView.mj_footer = footer;
}

- (void)zj_installRefreshHeader {
    __weak typeof(self) weakSelf     = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf zj_refreshAction];
    }];
    [header.lastUpdatedTimeLabel setHidden:true];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    [header setTitle:@"" forState:MJRefreshStateIdle];
    [header setTitle:@"" forState:MJRefreshStatePulling];
    self.collectionView.mj_header = header;
}

- (void)zj_uninstallRefreshHeader {
    [self.collectionView.mj_header removeFromSuperview];
    self.collectionView.mj_header = nil;
}
- (void)zj_uninstallRefreshFooter {
    [self.collectionView.mj_footer removeFromSuperview];
    self.collectionView.mj_footer = nil;
}

- (void)zj_loadMoreData {
    
}

- (void)zj_refreshAction {
    
}
- (void)zj_beginLoadingData {
    if (self.datasArray.count > 0) {
        return;
    }
    [super zj_beginLoadingData];
}

/**停止加载*/
- (void)zj_endingLoading {
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    [ZJWaitHUDView hide];
}
- (void)zj_readyReloadData:(ZJLoadMoreAction)loadMore {
    self.LoadMoreAction = [loadMore copy];
    [self setLoading:false];
    if (!self.isScrolling) {
        [self callRefreshAction];
    }
}


/**可以进行CollectionView 刷新操作了*/
- (void)callRefreshAction {
    if (self.LoadMoreAction) {
        self.LoadMoreAction();
        [self setLoadMoreAction:nil];
        [self.collectionView.mj_footer endRefreshing];
    }
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

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self zj_collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self zj_collectionViewWillEndScroll:scrollView];
    [self callRefreshAction];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self zj_collectionViewWillEndScroll:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setScrolling:true];
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

- (void)zj_collectionViewWillEndScroll:(UIScrollView *)scrollView {
    [self setScrolling:false];
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
    return 0;
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
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)zj_collectionView:(UICollectionView *)collectionView
          willDisplayCell:(UICollectionViewCell *)cell
       forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger maxCount = self.datasArray.count;
    if (self.datasDic.count > 0) {
        maxCount = self.datasDic.count;
    }
    NSInteger loadMoreIndex = maxCount - self.nextGap;
    if (maxCount < self.nextGap) {
        loadMoreIndex = self.datasDic.count / 2;
    }
    if (indexPath.row >= loadMoreIndex) {
        if (!self.isLoading) {
            [self.collectionView.mj_footer beginRefreshing];
            [self zj_loadMoreData];
        }
        else {
            [self setLoading:true];
        }
    }
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        CGRect frame = CGRectMake(0,
                                  ZJNavgationBarHeight,
                                  ZJScreenWidth,
                                  ZJScreenHeight - ZJNavgationBarHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame
                                             collectionViewLayout:[self zj_collectionViewFlowLayout]];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.bounces = true;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
    }
    return _collectionView;
}


- (ZMWaterFlowLayout *)flowLayout{
    if(!_flowLayout){
        if (_flowLayoutType == ZJFlowLayoutUnEqual) {
            _flowLayout = [self unequalFlowLayout];
        }
        else {
            _flowLayout = [self equalFlowLayout];
        }
    }
    return _flowLayout;
}

- (ZMWaterFlowLayout *)unequalFlowLayout {
    ZMWaterFlowLayout *flowLayout = [ZMWaterFlowLayout new];
    flowLayout.minimumLineSpacing      = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset      = UIEdgeInsetsMake(0, 10, -10, 10);
    
    flowLayout.scrollDirection   = UICollectionViewScrollDirectionVertical;
    flowLayout.columnMargin = 10;
    flowLayout.lineSpacing  = 10;
    flowLayout.waterFlowSection = 0;
    flowLayout.columnCount  = 2;
    return flowLayout;
}

- (UICollectionViewFlowLayout *)equalFlowLayout {
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing      = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset      = UIEdgeInsetsMake(0, 10, -10, 10);
    flowLayout.scrollDirection   = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionHeadersPinToVisibleBounds = true;

    return flowLayout;
}


- (NSMutableDictionary *)datasDic {
    if (!_datasDic) {
        _datasDic = [NSMutableDictionary new];
    }
    return _datasDic;
}


- (NSMutableArray *)datasArray{
    if(!_datasArray){
        _datasArray = [NSMutableArray new];
    }
    return _datasArray;
}


- (void)setResetTopOffset:(BOOL)resetTopOffset {
    _resetTopOffset = resetTopOffset;
    if (_resetTopOffset) {
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    else {
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ZJNavgationBarHeight);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }

}





@end
