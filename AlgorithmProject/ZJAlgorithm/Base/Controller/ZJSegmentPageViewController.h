//
//  ZJSegmentPageViewController.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJCategoryView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZJSegmentPageViewControllerDelegate <NSObject>

@optional;
- (void)segmentedPageViewControllerWillBeginDragging;
- (void)segmentedPageViewControllerDidEndDragging;
- (void)segmentedPageViewControllerDidEndDeceleratingWithPageIndex:(NSInteger)index;
- (void)segmentedDidChangeToViewController:(NSInteger )pageIndex;

@end

@interface ZJSegmentPageViewController : ZJBaseViewController


@property (nonatomic, strong) ZJCategoryView *categoryView;
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;
@property (nonatomic, strong, readonly) ZJBaseViewController *currentPageViewController;

@property (nonatomic, weak) id<ZJSegmentPageViewControllerDelegate> delegate;
@property (nonatomic, copy) NSArray<ZJBaseViewController *> *pageViewControllers;

- (void)makePageViewControllersScrollToTop;

- (void)makePageViewControllersScrollState:(BOOL)canScroll;

/**
 滑动到指定页面

 @param index index
 */
- (void)makePageScrollToIndex:(NSInteger)index;


/**
 设置当前展现的Controller

 @param currentPageViewController 当前展现的Controller
 */
- (void)setCurrentPageViewController:(ZJBaseViewController *)currentPageViewController;

@end

NS_ASSUME_NONNULL_END
