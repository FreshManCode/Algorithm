//
//  ZJBaseViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJBaseCommand.h"
#import <YYKit.h>

@interface ZJBaseViewController () <UIScrollViewDelegate>
/**存放用户数据同步的观察者列表 (A->B,B界面数据更新,A界面需要同步的时候)*/
@property (nonatomic, strong) NSHashTable <id <ZJObserverProtocol>> *observers;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ZJBaseViewController

/**
 带 command 命令的初始化方式
 @param command 对应的Command
 @return 实例变量
 */
+ (instancetype)initWithCommand:(ZJBaseCommand *)command {
    return [[self alloc] initWithCommand:command];
}

- (instancetype)initWithCommand:(ZJBaseCommand *)command {
    if (self = [super init]) {
        self.command   = command;
        self.observers = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:0];
        [self setEnableAutoKeyboard:true];
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self.navBarView.titleLab setText:title];
}

/**
 设置导航栏的type
 
 @param type type
 */
- (void)setNavBarType:(ZJNavBarType)type {
    switch (type) {
        case ZJNavBarNone: {
            [self.navBarView setHidden:true];
        }
            break;
        case ZJNavBarHideLeftButton: {
            [self.navBarView setHidden:false];
            [self.navBarView.leftButton setHidden:true];
        }
            break;
            
        default: {
            [self.navBarView setBackgroundColor:[UIColor whiteColor]];
            [self.navBarView setHidden:false];
        }
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_disableAutoInset];
    [self zj_addCustomNavigationBar];
    [self setNavBarType:ZJNavBarHideLeftButton];
    
}

- (void)zj_addCustomNavigationBar {
    [self.view addSubview:self.navBarView];
    [self.navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ZJStatusBarHeight);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    [self.navBarView.leftButton addTarget:self action:@selector(backButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView.rightButton addTarget:self action:@selector(wx_rightButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView.rightButton setHidden:true];
}

- (void)zj_leftButtonEvent {
    [self.command zj_backButtonEvent:self];
}

- (void)zj_rightButtonEvent {
    
}

- (void)backButtonEvent:(UIButton *)button {
    [self zj_leftButtonEvent];
}

- (void)wx_rightButtonEvent:(UIButton *)button {
    [self zj_rightButtonEvent];
}

- (void)setHideCustomNavBar:(BOOL)hideCustomNavBar {
    _hideCustomNavBar = hideCustomNavBar;
    [self.navBarView setHidden:hideCustomNavBar];
}

/**
 设置Scrollview 滑动偏移量为0 (子类需要重写)
 */
- (void)scrollToTop {
    [self.scrollView setContentOffset:CGPointZero];
}

- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
    self.scrollView.showsVerticalScrollIndicator = canScroll;
    if (!canScroll) {
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (void)zj_beginLoadingData {
    [self setRefreshing:true];
    [ZJWaitHUDView show:self.view];
    [self zj_autoRefresh];
}

/**
 展示说明图
 
 @param imageURL 图片URL
 */
- (void)showExplainImage:(NSString *)imageURL {
    if (!_imageView) {
        _imageView = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(20, ZJNavgationBarHeight, ZJScreenWidth - 20 * 2, 400)];
        _imageView.center = self.view.center;
    }
    __weak typeof(self) weakSelf     = self;
    [_imageView  setImageWithURL:[NSURL URLWithString:imageURL]
                     placeholder:nil
                         options:YYWebImageOptionAllowInvalidSSLCertificates
                      completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (image) {
            CGFloat kRatio = image.size.width / image.size.height;
            CGRect frame   = weakSelf.imageView.frame;
            frame.size.height    = image.size.width / kRatio;
            weakSelf.imageView.frame = frame;
        }
    }];
    [self.view addSubview:_imageView];
}




/**
 添加观察者 (用户数据同步,刷新)
 
 @param observer 观察者
 */
- (void)zj_addObserver:(id<ZJObserverProtocol>)observer {
    if (![self.observers containsObject:observer]) {
        [self.observers addObject:observer];
    }
}

/**
 移除观察者
 
 @param observer 观察者
 */
- (void)zj_removeObserver:(id<ZJObserverProtocol>)observer {
    if ([self.observers containsObject:observer]) {
        [self.observers removeObject:observer];
    }
}

- (void)setEnableAutoKeyboard:(BOOL)enableAutoKeyboard {
    _enableAutoKeyboard = enableAutoKeyboard;
    [IQKeyboardManager sharedManager].enable = enableAutoKeyboard;
    [IQKeyboardManager sharedManager].enableAutoToolbar = enableAutoKeyboard;
}

// MARK: - <ZJObserverProtocol>
- (void)updateState {
    
}

- (void)updateState:(ZJBaseModel *)model {
    
}

- (void)setTopDelegate:(id<ZJBaseViewControllerDelegate>)topDelegate {
    _topDelegate = topDelegate;
    _DelegateFlags.ZJLeaveTopDelegateTags = [_topDelegate respondsToSelector:@selector(pageViewControllerLeaveTop)];
    _DelegateFlags.ZJDidScrollDelegateTags = [_topDelegate respondsToSelector:@selector(baseScrollViewDidScroll:)];
    _DelegateFlags.ZJDidEndScrollDelegateTags = [_topDelegate respondsToSelector:@selector(baseScrollViewDidEndScrolling:)];
}

// MARK: - 禁用自动偏移量
- (void)p_disableAutoInset {
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollView = scrollView;
    if (self.canScroll) {
        if (scrollView.contentOffset.y <= 0) {
            self.canScroll = NO;
            if (_DelegateFlags.ZJLeaveTopDelegateTags) {
                [_topDelegate pageViewControllerLeaveTop];
            }
        }
    } else {
        self.canScroll = NO;
    }
}

- (dispatch_group_t)group{
    if(!_group){
        _group = dispatch_group_create();        
    }
    return _group;
}


- (ZJBaseCommand *)command{
    if(!_command){
        _command = [ZJBaseCommand new];
    }
    return _command;
}


- (ZJNavBarView *)navBarView{
    if(!_navBarView){
        _navBarView = [ZJNavBarView new];
    }
    return _navBarView;
}



@end
