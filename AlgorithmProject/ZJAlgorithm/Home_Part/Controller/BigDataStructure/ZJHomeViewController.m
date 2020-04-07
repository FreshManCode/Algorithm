//
//  ZJHomeViewController.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/30.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHomeViewController.h"
#import "ZJHomeListModel.h"
#import "ZJUploadImageManager.h"

@interface ZJHomeViewController ()

@property (nonatomic, strong) NSMutableArray <ZJHomeListModel *> *dataArray;

@end

@implementation ZJHomeViewController

static NSString * const kListCellID = @"UITableViewCell";

@dynamic dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"书籍列表"];
    [self configureUI];
}

- (void)configureUI {
    [self setNavBarType:ZJNavBarHideLeftButton];
    [self zj_registerSingleTableViewCell:[UITableViewCell class] cellID:kListCellID];
    [self.dataArray addObject:[ZJHomeListModel initWithBookName:@"大话数据结构"
                                                  pushClassName:@"ZJBigDataDesignVC"]];
    [self.dataArray addObject:[ZJHomeListModel initWithBookName:@"上传图片测试"
                                                  pushClassName:@""]];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)zj_tableView:(UITableView *)tableView
       configureCell:(UITableViewCell *)currentCell
           indexPath:(NSIndexPath *)indexPath {
    [currentCell.textLabel setText:self.dataArray[indexPath.row].bookName];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class pushClass =NSClassFromString( self.dataArray[indexPath.row].pushClassName);
    if (pushClass) {
        ZJBaseViewController *pushVC = [pushClass new];
        [self.navigationController pushViewController:pushVC animated:true];
        [pushVC setTitle:self.dataArray[indexPath.row].bookName];
    }
    else {
        [[ZJUploadImageManager manager] pushToSelectImageViewController:self];
    }
}




@end
