//
//  ZJBaseTableViewController.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJBaseTableView.h"
#import "ZJBaseNetAdapterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableViewController : ZJBaseViewController <ZJBaseNetAdapterProtocol>

@property (nonatomic, strong) ZJBaseTableView *tableView;


/**是否重置Tableview的起始约束*/
@property (nonatomic, assign) BOOL resetTopOffset;

/**数据源,子类可用dynamic关键字来重新定义对应的数据类型*/
@property (nonatomic, strong) NSMutableArray <id> *dataArray;




@end

NS_ASSUME_NONNULL_END
