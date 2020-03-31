//
//  ZJBaseTableView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJBaseTableView;
@protocol ZJBaseTableViewDelegate <NSObject>
@optional
- (void)zj_tableviewTouchBegan:(ZJBaseTableView *)tableView;
@end

@interface ZJBaseTableView : UITableView

@property (nonatomic, weak) id  <ZJBaseTableViewDelegate> ZJDelegate;

@property (nonatomic, assign) CGFloat categoryViewHeight;


@end

NS_ASSUME_NONNULL_END
