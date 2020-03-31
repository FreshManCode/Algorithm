//
//  ZJBaseStaticTableViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseStaticTableViewController.h"
@interface ZJBaseStaticTableViewController ()

@property (nonatomic, strong) NSMutableDictionary <NSNumber *,NSMutableArray *> *cellDict;


@end

@implementation ZJBaseStaticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cellDict];
}


// MARK: - ZJTableViewStaticProcol
- (void)zj_insertCell:(UITableViewCell *)cell
            inSection:(NSInteger)section
            withIndex:(NSInteger)index {
    NSMutableArray* cellSectionArray = [_cellDict objectForKey:[NSNumber numberWithInteger:section]];
    if (cellSectionArray == nil) {
        cellSectionArray = [NSMutableArray array];
        [_cellDict setObject:cellSectionArray forKey:[NSNumber numberWithInteger:section]];
    }
    if (index < cellSectionArray.count) {
        [cellSectionArray insertObject:cell atIndex:index];
    }
}

- (void)zj_insertCell:(UITableViewCell *)cell inSection:(NSInteger)section {
    NSMutableArray* cellSectionArray = [_cellDict objectForKey:[NSNumber numberWithInteger:section]];
    if (cellSectionArray == nil) {
        cellSectionArray = [NSMutableArray array];
        [_cellDict setObject:cellSectionArray forKey:[NSNumber numberWithInteger:section]];
    }
    [cellSectionArray addObject:cell];
    
}

- (void)zj_removeCell:(UITableViewCell *)cell inSection:(NSInteger)section {
    NSMutableArray* cellSectionArray = [_cellDict objectForKey:[NSNumber numberWithInteger:section]];
    if (cellSectionArray) {
        [cellSectionArray removeObject:cell];
    }
}

- (UITableViewCell*)zj_tableViewCellFromRow:(NSInteger)row andSection:(NSInteger)section {
    NSMutableArray* cellSectionArray = [_cellDict objectForKey:[NSNumber numberWithInteger:section]];
    if (cellSectionArray) {
        if (row < [cellSectionArray count]) {
            return [cellSectionArray objectAtIndex:row];
        }
    }
    return nil;
}

- (void)zj_removeAllCells {
    if (_cellDict) {
        [_cellDict removeAllObjects];
    }
}

// MARK: - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_cellDict allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray* cellSectionArray = [_cellDict objectForKey:[NSNumber numberWithInteger:section]];
    return [cellSectionArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* cellSectionArray = [_cellDict objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    UITableViewCell* cell = [cellSectionArray objectAtIndex:indexPath.row];
    return [self zj_staticCellHeight:cell tableView:tableView];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* cellSectionArray = [_cellDict objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    return cellSectionArray[indexPath.row];
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


- (CGFloat)zj_staticCellHeight:(UITableViewCell *)cell
                     tableView:(UITableView *)tableview {
    return [tableview fd_systemFittingHeightForConfiguratedCell:cell];
}

- (NSMutableDictionary *)cellDict{
    if(!_cellDict){
        _cellDict = [[NSMutableDictionary alloc] initWithCapacity:15];
    }
    return _cellDict;
}

@end
