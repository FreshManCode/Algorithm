//
//  ZJHotSortSelectedView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/1.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJHotSortSelectedView : ZJBaseTableViewContainerView

@property (nonatomic, strong) NSArray <NSString *> *datasArray;

@property (nonatomic, assign) NSInteger selectedIndex;



@end

NS_ASSUME_NONNULL_END
