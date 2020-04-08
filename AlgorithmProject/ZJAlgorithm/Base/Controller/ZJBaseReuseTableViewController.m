//
//  ZJBaseReuseTableViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseReuseTableViewController.h"

@interface ZJBaseReuseTableViewController ()

@property (nonatomic, strong) NSMutableDictionary <NSString *,Class> *singleDic;


@end

@implementation ZJBaseReuseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canScroll = true;
    [self zj_registerTableViewCell:self.tableView];
}

// MARK: - UITableViewDelegate,UITableViewDataSource
// MARK: - Register Cell
- (void)zj_registerTableViewCell:(UITableView *)tableView {
    
}

/**
 注册单一的cell (当一个Tableview中只有一种Cell时,使用该方法注册)
 
 @param cell 注册的Cell (在父类中实现,子类中传入对应的Cell即可)
 @param cellID cell的重用ID
 */
- (void)zj_registerSingleTableViewCell:(Class )cell
                                cellID:(NSString *)cellID {
    
    if (cellID.length < 1) {
        return;
    }
    [self.tableView registerClass:cell forCellReuseIdentifier:cellID];
    NSArray <NSString *> *cellIDS = self.singleDic.allKeys;
    if (cellIDS.count > 0) {
        NSString *oldCellID = cellIDS.firstObject;
        if (![oldCellID isEqualToString:cellID]) {
            return;
        }
    }
    [self.singleDic setObject:cell forKey:cellID];
    
}

// MARK: - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.01f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.singleDic.count > 0) {
        NSString *cellID = self.singleDic.allKeys.firstObject;
        return [self zj_tableView:tableView cellForRowWithIentifier:cellID indexPath:indexPath];
    }
    else {
//        NSAssert(false, @"子类要重写该方法");
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


// MARK: - ZJBaseResuseTableViewProtocol
// MARK: - Header/Footer
- (CGFloat)zj_tableView:(UITableView *)tableView
       viewHeightWithID:(NSString *)identifier
              inSection:(NSInteger)section {
    __weak typeof(self) weakSelf     = self;
    return [tableView fd_heightForHeaderFooterViewWithIdentifier:identifier configuration:^(id headerFooterView) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf zj_tableView:tableView viewHeaderOrFooterWithID:identifier inSection:section];
    }];
}

- (UIView *)zj_tableView:(UITableView *)tableView
viewHeaderOrFooterWithID:(NSString *)identifier
               inSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    [self zj_tableView:tableView configureView:headerFooterView inSection:section];
    return headerFooterView;
}
- (void)zj_tableView:(UITableView *)tableView
       configureView:(UITableViewHeaderFooterView *)headerFooterView
           inSection:(NSInteger)section {
    
}


- (CGFloat)zj_tableView:(UITableView *)tableView
     cellWithIdentifier:(NSString *)identifier
              indexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf     = self;
    return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath
                                       configuration:^(id cell) {
                                           __strong typeof(weakSelf) strongSelf = weakSelf;
                                           [strongSelf zj_tableView:tableView configureCell:cell indexPath:indexPath];
                                       }];
}

- (CGFloat)zj_tableViewNoCache:(UITableView *)tableView
            cellWithIdentifier:(NSString *)identifier
                     indexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf     = self;
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf zj_tableView:tableView configureCell:cell indexPath:indexPath];
    }];
}


- (UITableViewCell *)zj_tableView:(UITableView *)tableView
          cellForRowWithIentifier:(NSString *)identifier
                        indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [self zj_tableView:tableView configureCell:cell indexPath:indexPath];
    return cell;
}

- (void)zj_tableView:(UITableView *)tableView
       configureCell:(UITableViewCell *)currentCell
           indexPath:(NSIndexPath *)indexPath {
    
}


- (NSMutableDictionary *)singleDic{
    if(!_singleDic){
        _singleDic = [NSMutableDictionary new];
    }
    return _singleDic;
}



@end
