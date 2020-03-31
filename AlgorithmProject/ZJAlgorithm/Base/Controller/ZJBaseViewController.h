//
//  ZJBaseViewController.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJLibsHeader.h"
#import "ZJNavBarView.h"
#import "ZJObserverProtocol.h"
#import "ZJWaitHUDView.h"


NS_ASSUME_NONNULL_BEGIN

@protocol ZJBaseViewControllerDelegate <NSObject>
@optional;
- (void)pageViewControllerLeaveTop;
- (void)baseScrollViewDidScroll:(UIScrollView *)scrollView;

/**停止滑动
 @param scrollView scrollView
 */
- (void)baseScrollViewDidEndScrolling:(UIScrollView *)scrollView;
@end


@class ZJBaseCommand;

@interface ZJBaseViewController : UIViewController <ZJObserverProtocol>
{
    struct {
        unsigned int ZJLeaveTopDelegateTags : 1;
        unsigned int ZJDidScrollDelegateTags: 1;
        unsigned int ZJDidEndScrollDelegateTags: 1;
    }_DelegateFlags;
}

/**是否允许 键盘类自动防止键盘被遮挡 (默认为YES)*/
@property (nonatomic, assign) BOOL enableAutoKeyboard;

/** push/pop的命令 */
@property (nonatomic, strong) ZJBaseCommand *command;

/**自定义导航栏*/
@property (nonatomic, strong) ZJNavBarView *navBarView;

/**是否隐藏自定义Navbar,默认为Falase*/
@property (nonatomic, assign) BOOL hideCustomNavBar;

/**是否可以滑动 (子类需要重写)*/
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic,weak) id <ZJBaseViewControllerDelegate> topDelegate;

/**是否已经刷新过了,子类负责重载*/
@property (nonatomic, assign) BOOL refreshed;

/**是否正在加载中...,子类负责处理*/
@property (nonatomic, assign,getter = isRefreshing) BOOL refreshing;

/**线程组*/
@property (nonatomic, strong) dispatch_group_t group;

/**用来展示说明图*/
@property (nonatomic, strong) YYAnimatedImageView *imageView;

/**
 带 command 命令的Class初始化方式
 @param command 对应的Command
 @return 实例变量
 */
+ (instancetype)initWithCommand:(ZJBaseCommand *)command;

/**
 带 command 的实例初始化方式
 @param command 对应的Command
 @return 实例变量
 */
- (instancetype)initWithCommand:(ZJBaseCommand *)command;


/**
 设置导航栏的type

 @param type type
 */
- (void)setNavBarType:(ZJNavBarType)type;

/**
 添加观察者 (用户数据同步,刷新)

 @param observer 观察者
 */
- (void)zj_addObserver:(id<ZJObserverProtocol>)observer;

/**
 移除观察者

 @param observer 观察者
 */
- (void)zj_removeObserver:(id<ZJObserverProtocol>)observer;


- (void)zj_leftButtonEvent;

- (void)zj_rightButtonEvent;

// MARK: - <ZJObserverProtocol>
- (void)updateState;

- (void)updateState:(ZJBaseModel *)model;

/**
 设置Scrollview 滑动偏移量为0 (子类需要重写)
 */
- (void)scrollToTop;

/**
 设置对应Scrollview 的偏移量

 @param contentOffset 偏移量
 */
- (void)setContentOffset:(CGPoint)contentOffset;


- (void)zj_beginLoadingData;

/**第一次加载过来的时候,自动请求,子类重写该方法即可*/
- (void)zj_autoRefresh;



/**
 展示说明图

 @param imageURL 图片URL
 */
- (void)showExplainImage:(NSString *)imageURL;



@end

NS_ASSUME_NONNULL_END
