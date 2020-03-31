//
//  ZJBaseTableViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewController.h"
#import "ZJBaseNetAdapter.h"


@interface ZJBaseTableViewController () <ZJBaseTableViewDelegate>

@end

@implementation ZJBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configureDefaultSetting];
    [self zj_loadViews];
}

- (void)p_configureDefaultSetting {
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)zj_loadViews {
    [self.view addSubview:self.tableView];
    [self zj_addConstraints];
}
- (void)zj_addConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ZJNavgationBarHeight);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

// MARK: - ZJBaseTableViewDelegate
- (void)zj_tableviewTouchBegan:(ZJBaseTableView *)tableView {
    if (tableView == self.tableView) {
        [self.view endEditing:true];
    }
}

// MARK: - ZJBaseNetAdapterProtocol
- (void)ZJBaseNetAdapterDelegate:(ZJBaseNetAdapter *)adapter
                       beforeRun:(ZJBaseNetModel *)param {
    if (adapter.defaultRequestUIHandle) {
        [self setRefreshing:false];
        [self.view endEditing:true];
        [ZJWaitHUDView show:self.view];
    }
}

- (void)setResetTopOffset:(BOOL)resetTopOffset {
    _resetTopOffset = resetTopOffset;
    if (_resetTopOffset) {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    else {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(ZJNavgationBarHeight);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
}


// MARK: - Getter---Setter
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[ZJBaseTableView  alloc]initWithFrame:CGRectMake(0, 0, ZJScreenWidth, 0.01) style:UITableViewStyleGrouped];
        [(ZJBaseTableView *)_tableView  setZJDelegate:self];
        _tableView.delegate   =  (id) self;
        _tableView.dataSource =  (id) self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 244;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth, 0.01)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenHeight, 0.01)];
        if (@available(iOS 11.0,*)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = false;
        }
    }
    return _tableView;
}


- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray new];
        
    }
    return _dataArray;
}


@end
