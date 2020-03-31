//
//  ZJFinderHomeViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJFinderHomeViewController.h"
#import "ZJHomeGoodsViewController.h"
#import "ZJHomeGoodsHeaderViewController.h"
#import "ZJConstHeader.h"


@interface ZJFinderHomeViewController ()
<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,ZJBaseViewControllerDelegate,ZJSegmentPageViewControllerDelegate>

@property (nonatomic, strong) UIView  *headerView;
@property (nonatomic, strong) ZJSearchView *searchView;
@property (nonatomic, strong) ZJBaseTableView *tableView;
@property (nonatomic, strong) ZJSegmentPageViewController *segmentController;
@property (nonatomic) BOOL cannotScroll;
//@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) ZJCategoryView *categoryView;
@property (nonatomic, strong) NSArray *titles;
/**搜索栏是否是吸顶状态*/
@property (nonatomic, assign,getter = isTopState) BOOL topState;

@end

@implementation ZJFinderHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    //可以在请求数据成功后设置/改变pageViewControllers, 但是要保证titles.count=pageViewControllers.count
    [self setupPageViewControllers];
}



#pragma mark - Private Methods

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(ZJStatusBarHeight, 0, 0, 0));
    }];
}

- (void)setupPageViewControllers {
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        ZJBaseViewController *controller;
        if (i == 0) {
            controller = [[ZJHomeGoodsHeaderViewController alloc] init];
        }
        else if (i % 3 == 0) {
            controller = [[ZJHomeGoodsViewController alloc] init];
            [(ZJHomeGoodsViewController*)controller setName:self.titles[i]];
        } else if (i % 2 == 0) {
            controller = [[ZJHomeGoodsViewController alloc] init];
            [(ZJHomeGoodsViewController*)controller setName:self.titles[i]];
        } else {
            controller = [[ZJHomeGoodsViewController alloc] init];
            [(ZJHomeGoodsViewController*)controller setName:self.titles[i]];
        }
        controller.topDelegate = self;
        [controllers addObject:controller];
    }
    self.categoryView.alignment = ZJCategoryViewAlignmentCenter;
    self.categoryView.originalIndex = self.selectedIndex;
    self.categoryView.isEqualParts = YES;
    self.segmentController.pageViewControllers = controllers;

    self.segmentController.categoryView = self.categoryView;
}

// MARK: - ZJBaseViewControllerDelegate
- (void)baseScrollViewDidScroll:(UIScrollView *)scrollView {
   [self changeTopViewWithScrollView:scrollView];
}
/**
 根据滑动处理 搜索框以及顶部标签栏
 @param scrollView 滑动
 */
- (void)changeTopViewWithScrollView:(UIScrollView *)scrollView {
//  是否正在重置偏移量
    __block BOOL resetContentOffset = false;
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    CGFloat searchAlpha    = 1.0f;
//  吸顶状态tableview 向上偏移量
    CGFloat topStateOffset = kTopViewH - kSearchViewH - ZJStatusBarHeight / 2.f;
    CGPoint vel = [scrollView.panGestureRecognizer translationInView:scrollView];
    //向上滑动
    if (vel.y < -0 ) {
        //搜索框是吸顶状态
        if (self.isTopState) {
            return;
        }
        //从另一个界面切换过来,现在的界面向上的偏移量大于吸顶状态的偏移量
        else if (currentOffsetY >= topStateOffset) {
            [self.tableView setContentOffset:CGPointMake(0,topStateOffset) animated:true];
            searchAlpha = 0.f;
            [self setTopState:true];
            return;
        }
        //向上拖动
    } else if (vel.y >0) {
        //向下拖动
    } else if (vel.y == 0) {
        //停止拖拽
    }

    if (currentOffsetY > 0 && currentOffsetY < topStateOffset) {
        [self.tableView setContentOffset:CGPointMake(0,currentOffsetY)];
        searchAlpha =  (kTopViewH - ZJStatusBarHeight - currentOffsetY ) / kTopViewH;
        [self setTopState:false];
    }
    else if (currentOffsetY >= topStateOffset) {
        [self.tableView setContentOffset:CGPointMake(0,topStateOffset)];
        searchAlpha = 0.f;
        [self setTopState:true];
    }
    else {
        if (!resetContentOffset) {
            resetContentOffset = true;
            [UIView animateWithDuration:0.2f
                             animations:^{
                [self.tableView setContentOffset:CGPointZero];
            } completion:^(BOOL finished) {
                resetContentOffset = false;
                [self setTopState:false];
            }];
        }
    }
    [self.searchView setAlpha:searchAlpha];
}


#pragma mark - UIScrollViewDelegate
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    [self.segmentController makePageViewControllersScrollToTop];
    return YES;
}

/**
 * 处理联动
 * 如果不实现该方法,baseScrollViewDidScroll:方法不走
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellID forIndexPath:indexPath];
    [self addChildViewController:self.segmentController];
    [cell.contentView addSubview:self.segmentController.view];
    [self.segmentController didMoveToParentViewController:self];
    [self.segmentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ZJScreenHeight - kTopViewH;
}

//解决tableView在group类型下tableView头部和底部多余空白的问题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.categoryView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kSearchViewH ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - HGSegmentedPageViewControllerDelegate
- (void)segmentedPageViewControllerWillBeginDragging {
    self.tableView.scrollEnabled = NO;
}

- (void)segmentedPageViewControllerDidEndDragging {
    self.tableView.scrollEnabled = YES;
}

#pragma mark - HGPageViewControllerDelegate
- (void)pageViewControllerLeaveTop {
    [self.segmentController makePageViewControllersScrollToTop];
    self.cannotScroll = NO;
}


#pragma mark - Lazy

- (ZJSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[ZJSearchView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth, kSearchViewH)];
        [_searchView setBackgroundColor:[UIColor whiteColor]];
    }
    return _searchView;
}


- (ZJCategoryView *)categoryView{
    if(!_categoryView){
        __weak typeof(self) weakSelf     = self;
        _categoryView = [[ZJCategoryView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth,kDefaultCategoryViewH)];
        [_categoryView setAlignment:ZJCategoryViewAlignmentLeft];
        _categoryView.itemWidth       = kCategoryItemW;
        _categoryView.itemNormalWidth = kCategoryNormalItemW;
        _categoryView.itemSpacing   = 5.f;
        _categoryView.leftAndRightMargin = 5.f;
        [_categoryView setTitles:self.titles];
        _categoryView.selectedItemHelper = ^(NSUInteger index) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.segmentController makePageScrollToIndex:index];
        };
    }
    return _categoryView;
}


//- (UIView *)footerView {
//    if (!_footerView) {
//        //如果当前控制器存在TabBar/ToolBar, 还需要减去TabBarHeight/ToolBarHeight和SAFE_AREA_INSERTS_BOTTOM
//        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - ZJStatusBarHeight)];
//    }
//    return _footerView;
//}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[ZJBaseTableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellID];
    }
    return _tableView;
}

- (ZJSegmentPageViewController *)segmentController {
    if (!_segmentController) {
        _segmentController = [[ZJSegmentPageViewController alloc] init];
        _segmentController.delegate = self;
    }
    return _segmentController;
}


- (UIView *)headerView{
    if(!_headerView){
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSearchViewH + kViewGap)];
        [_headerView setBackgroundColor:[UIColor whiteColor]];
        [_headerView addSubview:self.searchView];
    }
    return _headerView;
}


- (NSArray *)titles{
    if(!_titles){
        NSArray *titles = @[@"热门", @"国货", @"开箱", @"穿搭",@"最新",@"附近"];
        _titles =  titles;
    }
    return _titles;
}



@end
