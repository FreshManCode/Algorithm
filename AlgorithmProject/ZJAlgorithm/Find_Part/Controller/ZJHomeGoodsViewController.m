//
//  ZJHomeGoodsViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHomeGoodsViewController.h"
#import "ZJFlowLayoutCell.h"
#import "ZJDiscoverlistItemModel.h"
#import "ZJHomeLoadImageCell.h"


#define kMaxWidth  floorf((ZJScreenWidth - 30 )/2.0)

@interface ZJHomeGoodsViewController ()

@property (nonatomic, strong) NSMutableArray <ZJDiscoverlistItemModel *> *tempArray;
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) NSMutableArray <ZJDiscoverlistItemModel *>*datasArray ;


@end

@implementation ZJHomeGoodsViewController

@dynamic datasArray;

static NSString * const kLoadImageCellID = @"ZJHomeLoadImageCellID";

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
    [self p_initData];
}

- (void)p_initData {
        ZJDispatch_async(^{
            NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"TestImage" ofType:@"json"];
            NSData *jsonData = [NSData dataWithContentsOfFile:bundlePath];
            if (jsonData) {
                NSError *error = nil;
                id json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
                NSArray <NSDictionary *> * dicArray = (NSArray *)json;
                if (json && [json isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dic in dicArray) {
                        ZJDiscoverlistItemModel *model = [ZJDiscoverlistItemModel modelWithDictionary:dic];
                        [self.tempArray addObject:model];
                    }
                }
            }
            [self.datasArray removeAllObjects];
            [self.datasArray addObjectsFromArray:[self getDataCount:50]];
            ZJDispatch_asyncMain(^{
                [self zj_endingLoading];
                [self.collectionView reloadData];
            });
        });
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


- (void)setContentOffset:(CGPoint)contentOffset {
    if (self.collectionView.contentOffset.y < contentOffset.y) {
        [self.collectionView setContentOffset:contentOffset];
    }
}


- (void)zj_registercollectionViewCell:(UICollectionView *)collectionView {
    [collectionView registerClass:[ZJHomeLoadImageCell class]
       forCellWithReuseIdentifier:kLoadImageCellID];
}

- (UICollectionViewCell *)zj_collectionView:(UICollectionView *)collectionView
                                  indexPath:(NSIndexPath *)indexPath {
    ZJHomeLoadImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLoadImageCellID
                                                                          forIndexPath:indexPath];
    [cell setListItemModel:self.datasArray[indexPath.row] collectionView:collectionView];
    
    return cell;
}

- (NSInteger)zj_collectionView:(UICollectionView *)collectionView
        numberOfItemsInSection:(NSInteger)section {
    return self.datasArray.count;
}

- (CGSize)zj_collectionView:(UICollectionView *)collectionView
                     layout:(UICollectionViewLayout *)collectionViewLayout
     sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJDiscoverlistItemModel *listModel = self.datasArray[indexPath.row];
    return CGSizeMake(kMaxWidth, listModel.kImageHeight) ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s--%ld",__func__,indexPath.row);
}

// MARK: -ZJBaseViewControllerDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//  把滑动事件抛出去,让主Controller 处理对应的逻辑
    if (_DelegateFlags.ZJDidScrollDelegateTags) {
        [self.topDelegate baseScrollViewDidScroll:scrollView];
    }
}

- (void)zj_collectionViewWillEndScroll:(UIScrollView *)scrollView {
    [super zj_collectionViewWillEndScroll:scrollView];
    if (_DelegateFlags.ZJDidEndScrollDelegateTags) {
        [self.topDelegate baseScrollViewDidEndScrolling:scrollView];
    }
}


- (NSMutableArray *)tempArray{
    if(!_tempArray){
        _tempArray = [NSMutableArray new];
    }
    return _tempArray;
}



@end

