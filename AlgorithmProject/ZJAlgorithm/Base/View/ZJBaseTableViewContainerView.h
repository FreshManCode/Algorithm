//
//  ZJBaseTableViewContainerView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/1.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJTableViewReuseProtocol.h"

@class ZJBaseTableViewContainerView;

@protocol ZJBaseTableViewContainerViewDelegate <NSObject>

- (void)tableContainerView:(ZJBaseTableViewContainerView *)containerView
             didClickIndex:(NSInteger)index;


/**
 视图消失了

 @param containerView containerView
 */
- (void)tableContainerViewDidDissmiss:(ZJBaseTableViewContainerView *)containerView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableViewContainerView : UIView
<ZJTableViewReuseProtocol,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) id <ZJBaseTableViewContainerViewDelegate> delegate;
//子类使用dynamic 关键字重载 (数据源)
@property (nonatomic, strong) NSMutableArray <NSObject *>  * listsArray;

@property (nonatomic, strong) UITableView *tableView;
/**动画时长*/
@property (nonatomic, assign) NSTimeInterval animateDuration;


- (void)notiSelectedIndex:(NSInteger)index;

- (void)showInView:(UIView *)view;

- (void)dismissView;

- (void)dismissView:(nullable void(^)(void))complete;

@end

NS_ASSUME_NONNULL_END
