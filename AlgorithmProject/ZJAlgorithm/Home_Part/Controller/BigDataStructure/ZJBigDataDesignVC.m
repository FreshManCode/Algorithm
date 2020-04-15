//
//  ZJBigDataDesignVC.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/30.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBigDataDesignVC.h"
#import "ZJDesignCell.h"
#import "ZJSectionModel.h"

@interface ZJBigDataDesignVC ()

@property (nonatomic, strong) NSMutableArray <ZJSectionModel *> *dataArray;


@end

@implementation ZJBigDataDesignVC

@dynamic dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarType:ZJNavBarDefault];
    [self configureUI];
}

- (void)configureUI {
    [self zj_registerSingleTableViewCell:[ZJDesignCell class] cellID:kDesignCellID];
    [self.dataArray addObjectsFromArray:[self sectionsArray]];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)zj_tableView:(UITableView *)tableView
       configureCell:(UITableViewCell *)currentCell
           indexPath:(NSIndexPath *)indexPath {
    ZJDesignCell *cell = (ZJDesignCell *)currentCell;
    [cell setText:self.dataArray[indexPath.row].sectionName];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class pushClass =NSClassFromString( self.dataArray[indexPath.row].sectionClassName);
    if (pushClass) {
        ZJBaseViewController *pushVC = [pushClass new];
        [self.navigationController pushViewController:pushVC animated:true];
        [pushVC setTitle:self.dataArray[indexPath.row].sectionName];
    }
}

- (NSMutableArray <ZJSectionModel *> *)sectionsArray {
    NSMutableArray *tempArray = [NSMutableArray new];
    for (int i = 0; i < 6; i ++) {
        ZJSectionModel *sectionModel = [ZJSectionModel new];
        if (i == 0) {
            sectionModel.sectionName = @"第一章:数据结构简介";
            sectionModel.sectionClassName = @"ZJDataSectionOneVC";
        }
        else if (i == 1) {
            sectionModel.sectionName = @"第二章:算法";
            sectionModel.sectionClassName = @"ZJDataSectionTwoVC";
        }
        else if (i == 2) {
            sectionModel.sectionName = @"第三章:线性表";
            sectionModel.sectionClassName = @"ZJDataSectionThreeVC";
        }
        else if (i == 3) {
            sectionModel.sectionName = @"第三章:线性表二";
            sectionModel.sectionClassName = @"ZJDataSectionThreeVC2";
        }
        else if (i == 4) {
            sectionModel.sectionName = @"第四章:栈与队列";
            sectionModel.sectionClassName = @"ZJDataSectionFourVC";
        }
        else if (i == 5) {
            sectionModel.sectionName = @"第五章:串";
            sectionModel.sectionClassName = @"ZJDataSectionFiceVC";
        }
        else if (i == 6) {
            sectionModel.sectionName = @"第六章:树";
            sectionModel.sectionClassName = @"ZJDataSectionSixVC";
        }
        [tempArray addObject:sectionModel];
    }
    return tempArray;
}




@end
