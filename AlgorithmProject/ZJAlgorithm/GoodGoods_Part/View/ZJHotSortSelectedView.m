//
//  ZJHotSortSelectedView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/1.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHotSortSelectedView.h"
#import "ZJHotSortItemCell.h"

@interface ZJHotSortSelectedView ()

@property (nonatomic, strong) NSMutableArray <NSString *> *listsArray;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation ZJHotSortSelectedView

static CGFloat const kViewH = 45.f;


@dynamic listsArray;

- (void)showInView:(UIView *)view {
    [super showInView:view];
    [self.bottomView setBackgroundColor:self.backgroundColor];
    [ZJ_AppWindow() addSubview:self.bottomView];
}

- (void)dismissView:(void (^)(void))complete {
    [super dismissView:^{
        [self.bottomView removeFromSuperview];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kViewH;
}

- (void)zj_registerTableViewCell:(UITableView *)tableView {
    [tableView registerClass:[ZJHotSortItemCell class] forCellReuseIdentifier:kHotSortItemCellID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self zj_tableView:tableView cellForRowWithIentifier:kHotSortItemCellID indexPath:indexPath];
}
- (void)zj_tableView:(UITableView *)tableView
       configureCell:(UITableViewCell *)currentCell
           indexPath:(NSIndexPath *)indexPath {
    ZJHotSortItemCell *cell = (ZJHotSortItemCell *)currentCell;
    [cell setTitle:self.listsArray[indexPath.row] selected:self.selectedIndex == indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [self.tableView reloadData];
    [self notiSelectedIndex:self.selectedIndex];
    [self dismissView];
}

- (void)setDatasArray:(NSArray<NSString *> *)datasArray {
    _datasArray = datasArray;
    [self.listsArray addObjectsFromArray:datasArray];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kViewH * datasArray.count);
    }];
}


- (UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ZJScreenHeight - ZJTabBarHeight, ZJScreenWidth, ZJTabBarHeight)];
    }
    return _bottomView;
}



@end
