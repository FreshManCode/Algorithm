//
//  ZJBaseReuseTableViewController.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewController.h"
#import "ZJTableViewReuseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseReuseTableViewController : ZJBaseTableViewController

<ZJTableViewReuseProtocol,UITableViewDelegate,UITableViewDataSource>

@end

NS_ASSUME_NONNULL_END
