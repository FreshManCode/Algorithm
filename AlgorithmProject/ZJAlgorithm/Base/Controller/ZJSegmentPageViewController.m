//
//  ZJSegmentPageViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJSegmentPageViewController.h"
#import <Masonry.h>
#import "ZJCompatibleScrollView.h"


#define kWidth self.view.frame.size.width

@interface ZJSegmentPageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) ZJCompatibleScrollView *scrollView;
@property (nonatomic, strong) ZJBaseViewController *currentPageViewController;
@property (nonatomic) NSInteger currentPageIndex;
@property (nonatomic) CGFloat whenBeginDraggingContentOffsetX;

@end

@implementation ZJSegmentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHideCustomNavBar:true];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - Public Methods
- (void)makePageViewControllersScrollToTop {
    [self.pageViewControllers enumerateObjectsUsingBlock:^(ZJBaseViewController * obj, NSUInteger idx, BOOL *  stop) {
        [obj scrollToTop];
    }];
}

- (void)makePageViewControllersScrollState:(BOOL)canScroll {
    [self.pageViewControllers enumerateObjectsUsingBlock:^(ZJBaseViewController * obj, NSUInteger idx, BOOL *  stop) {
        obj.canScroll = canScroll;
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.whenBeginDraggingContentOffsetX = scrollView.contentOffset.x;
    if ([self.delegate respondsToSelector:@selector(segmentedPageViewControllerWillBeginDragging)]) {
        [self.delegate segmentedPageViewControllerWillBeginDragging];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale      = scrollView.contentOffset.x / kWidth;
    NSInteger leftPage = floor(scale);
    NSInteger rightPage = ceil(scale);
    
    if (scrollView.contentOffset.x > self.whenBeginDraggingContentOffsetX) { //向右切换
        if (leftPage == rightPage) {
            leftPage = rightPage - 1;
        }
        if (rightPage < self.pageViewControllers.count) {
            [self.categoryView scrollToTargetIndex:rightPage sourceIndex:leftPage percent:scale - leftPage];
        }
    } else { //向左切换
        if (leftPage == rightPage) {
            rightPage = leftPage + 1;
        }
        if (rightPage < self.pageViewControllers.count) {
            [self.categoryView scrollToTargetIndex:leftPage sourceIndex:rightPage percent:1 - (scale - leftPage)];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delegate respondsToSelector:@selector(segmentedPageViewControllerDidEndDragging)]) {
        [self.delegate segmentedPageViewControllerDidEndDragging];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = (NSUInteger)(self.scrollView.contentOffset.x / kWidth);
    self.currentPageIndex = index;
    if ([self.delegate respondsToSelector:@selector(segmentedPageViewControllerDidEndDeceleratingWithPageIndex:)]) {
        [self.delegate segmentedPageViewControllerDidEndDeceleratingWithPageIndex:index];
    }
}

#pragma mark - Setters
- (void)setCurrentPageIndex:(NSInteger)currentPageIndex {
    self.currentPageViewController = self.pageViewControllers[self.categoryView.selectedIndex];
    if (_delegate && [_delegate respondsToSelector:@selector(segmentedDidChangeToViewController:)]) {
        [_delegate segmentedDidChangeToViewController:currentPageIndex];
    }
}

- (void)setPageViewControllers:(NSArray<ZJBaseViewController *> *)pageViewControllers {
    if (self.pageViewControllers.count > 0) {
        //remove pageViewControllers
        [self.pageViewControllers enumerateObjectsUsingBlock:^(ZJBaseViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj willMoveToParentViewController:nil];
            [obj.view removeFromSuperview];
            [obj removeFromParentViewController];
        }];
    }
    
    _pageViewControllers = pageViewControllers;
    
    //add pageViewControllers
    [self.pageViewControllers enumerateObjectsUsingBlock:^(ZJBaseViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:obj];
        [self.scrollView addSubview:obj.view];
        [obj didMoveToParentViewController:self];
        [obj.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(idx * kWidth);
            make.top.width.height.equalTo(self.scrollView);
        }];
    }];
    
    self.scrollView.contentSize = CGSizeMake(kWidth * self.pageViewControllers.count, 0);
    self.categoryView.userInteractionEnabled = YES;
    self.currentPageIndex = self.categoryView.originalIndex;
}

/**
 滑动到指定页面
 
 @param index index
 */
- (void)makePageScrollToIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(index * kWidth, 0) animated:NO];
    self.currentPageIndex = index;
}

/**
 设置当前展现的Controller
 
 @param currentPageViewController 当前展现的Controller
 */
- (void)setCurrentPageViewController:(ZJBaseViewController *)currentPageViewController {
    _currentPageViewController = currentPageViewController;
    [currentPageViewController zj_beginLoadingData];
}


#pragma mark - Getters
- (ZJCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[ZJCategoryView alloc] init];
        _categoryView.userInteractionEnabled = NO;
        @weakify(self)
        _categoryView.selectedItemHelper = ^(NSUInteger index) {
            @strongify(self)
            [self.scrollView setContentOffset:CGPointMake(index * kWidth, 0) animated:NO];
            self.currentPageIndex = index;
        };
    }
    return _categoryView;
}

- (ZJCompatibleScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[ZJCompatibleScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}



@end
