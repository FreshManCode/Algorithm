//
//  ZJBaseTableViewCell.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJLibsHeader.h"
#import "ZJEdgesInsets.h"

NS_ASSUME_NONNULL_BEGIN
//cell 添加分割线
typedef NS_ENUM(NSInteger,ZJCellSepratorType) {
    ZJCellSepratorNone         = 0, //无分割线
    ZJCellSepratorTop          = 1,//顶部
    ZJCellSepratorBottom       = 2,//底部
    ZJCellSepratorTopAndBottom = 3,//顶部和底部
};


@interface ZJBaseTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) ZJCellSepratorType sepratorType;
@property (nonatomic, assign) ZJCellEdgeinset Edgeinset;


- (void)zj_addSubviews ;

- (void)zj_addConstraints ;



@end

NS_ASSUME_NONNULL_END
