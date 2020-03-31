//
//  ZJHomeGoodsHeaderViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHomeGoodsHeaderViewController.h"
#import "ZJHomeCollectionHeaderView.h"
#import "ITRowModel.h"
#import "ZJFlowLayoutCell.h"
#import "ZJCycleLoopCollectionViewCell.h"
#import "ZJBannerLoopCell.h"
#import "ZJBigContainerTableViewCell.h"
#import "ZJHomeGoodsViewController.h"
#import "WatchFlowLayout.h"

@interface ZJHomeGoodsHeaderViewController () <WatchFlowLayoutDelegate>

@property (nonatomic, strong) NSMutableArray <ITRowModel *> *datasArray;
@property (nonatomic, strong) NSMutableArray <NSString *> *imageURLS;
@property (nonatomic, strong) WatchFlowLayout *watchFlowLayout;

@end

@implementation ZJHomeGoodsHeaderViewController

@dynamic datasDic;
@dynamic datasArray;


static NSString * const kFlowLayoutCellID = @"ZJFlowLayoutCellID";

static NSString * const kCycleLoopCellID  = @"ZJCycleLoopCollectionViewCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHideCustomNavBar:true];
    [self setResetTopOffset:true];
    [self zj_uninstallRefreshFooter];
}

- (void)zj_refreshAction {
    [self zj_autoRefresh];
}

- (void)zj_autoRefresh {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.datasArray removeAllObjects];
        [self.datasArray addObjectsFromArray:[self loopModel:80]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self zj_endingLoading];
            [self.collectionView reloadData];
        });
    });
    [self.view setBackgroundColor:[UIColor redColor]];
}

- (void)zj_loadMoreData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.datasArray addObjectsFromArray:[self loopModel:30]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self zj_readyReloadData:^{
                [self.collectionView reloadData];
            }];
        });
    });
}

- (NSArray *)loopModel:(NSInteger)maxCount {
    NSInteger startIndex = self.datasArray.count;
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:maxCount];
    @autoreleasepool {
        for (int i = 0 ; i < maxCount; i ++) {
            NSString *text = @"0";
            int a = i ;
            while (a > 0 ) {
                text = [NSString stringWithFormat:@"%@_%d",text,a];
                a --;
            }
            ITRowModel *rowModl = [ITRowModel new];
            rowModl.name = @"HomeHeaderView";
            rowModl.text = text;
            rowModl.contentSize = [rowModl sizeWithText:text];
            [self.datasDic setObject:rowModl forKey:@(i + startIndex)];
            [tempArray addObject:rowModl];
        }
    }
    return tempArray;
}
- (void)setContentOffset:(CGPoint)contentOffset {
    if (self.collectionView.contentOffset.y < contentOffset.y) {
        [self.collectionView setContentOffset:contentOffset];
    }
}

- (void)zj_registercollectionViewCell:(UICollectionView *)collectionView {
    [collectionView registerClass:[ZJFlowLayoutCell class]
       forCellWithReuseIdentifier:kFlowLayoutCellID];
    [collectionView registerClass:[ZJCycleLoopCollectionViewCell class]
       forCellWithReuseIdentifier:kCycleLoopCellID];
}

- (NSInteger)zj_numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datasArray.count > 0  ? 2 : 0;
}
- (NSInteger)zj_collectionView:(UICollectionView *)collectionView
        numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.datasArray.count;
}

- (UICollectionViewCell *)zj_collectionView:(UICollectionView *)collectionView
                                  indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZJCycleLoopCollectionViewCell *loopCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCycleLoopCellID forIndexPath:indexPath];
        [loopCell setBanners:self.imageURLS];
        return loopCell;
    }
    
    ZJFlowLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFlowLayoutCellID
                                                                       forIndexPath:indexPath];
    [cell setRowModel:self.datasArray[indexPath.row]];
    return cell;
}

- (UICollectionViewLayout *)zj_collectionViewFlowLayout {
    return self.watchFlowLayout;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s--%ld",__func__,indexPath.row);
}

#pragma mark - WatchFlowLayoutDelegate

- (NSInteger)numberOfSection {
    return self.datasArray.count > 0 ? 2 : 0;
}

- (NSInteger)numberOfColumnInSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(ZJScreenWidth, 140.f);
    }
    return [self.datasArray[indexPath.row] contentSize];
}

- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.f;
}

- (UIEdgeInsets)contentInsetOfSectionAtIndex:(NSInteger)section {    
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


// MARK: -ZJBaseViewControllerDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //  把滑动事件抛出去,让主Controller 处理对应的逻辑
    if (_DelegateFlags.ZJDidScrollDelegateTags) {
        [self.topDelegate baseScrollViewDidScroll:scrollView];
    }
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

- (WatchFlowLayout *)watchFlowLayout{
    if(!_watchFlowLayout){
        _watchFlowLayout = [WatchFlowLayout new];
        _watchFlowLayout.flowDelegate = self;
    }
    return _watchFlowLayout;
}



@end
