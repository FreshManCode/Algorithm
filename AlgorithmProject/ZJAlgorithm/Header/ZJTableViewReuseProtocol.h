//
//  ZJTableViewReuseProtocol.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJTableViewStaticProcol <NSObject>
@optional;

// MARK: - Static Cell
/**
 在Section 插入一个Cell
 
 @param cell cell
 @param section section
 */
- (void)zj_insertCell:(UITableViewCell*)cell inSection:(NSInteger)section;


/**
 在Section  指定的位置 插入一个Cell
 
 @param cell cell
 @param section section
 @param index index
 */
- (void)zj_insertCell:(UITableViewCell*)cell inSection:(NSInteger)section withIndex:(NSInteger)index;

/**
 移除所有的Cell
 */
- (void)zj_removeAllCells;

/**
 移除某个section的Cell

 @param cell cell
 @param section section
 */
- (void)zj_removeCell:(UITableViewCell*)cell inSection:(NSInteger)section;


/**
 获取指定section以及row的cell
 
 @param row row
 @param section section
 @return UITableViewCell 实例对象
 */
- (UITableViewCell*)zj_tableViewCellFromRow:(NSInteger)row andSection:(NSInteger)section;


@end


@protocol ZJTableViewReuseProtocol <NSObject>

@optional;

// MARK: - Header/Footer view
/**
 通过ID 获取header/footer高度
 
 @param tableView tableView
 @param identifier ID
 @param section section
 @return 高度
 */
- (CGFloat)zj_tableView:(UITableView *)tableView
       viewHeightWithID:(NSString *)identifier
              inSection:(NSInteger)section;

/**
 通过ID 获取header/footer
 
 @param tableView tableView
 @param identifier 重用标识符
 @param section section
 @return view
 */
- (UIView *)zj_tableView:(UITableView *)tableView
viewHeaderOrFooterWithID:(NSString *)identifier
               inSection:(NSInteger)section;


/**
 配置 header/footer view
 
 @param tableView tableView
 @param headerFooterView  对应的 header / footer view
 @param section section
 */
- (void)zj_tableView:(UITableView *)tableView
       configureView:(UITableViewHeaderFooterView *)headerFooterView
           inSection:(NSInteger)section;

// MARK: - TableViewCell
/**
 注册重用的Cell
 
 @param tableView tableView
 */
- (void)zj_registerTableViewCell:(UITableView *)tableView;



/**
 注册单一的cell (当一个Tableview中只有一种Cell时,使用该方法注册)

 @param cell 注册的Cell (在父类中实现,子类中传入对应的Cell即可)
 @param cellID cell的重用ID
 */
- (void)zj_registerSingleTableViewCell:(Class )cell
                                cellID:(NSString *)cellID;


/**
 通过ID 获取Cell高度
 
 @param tableView tableView
 @param identifier 重用标识符
 @param indexPath 对应的indexPath
 @return cell高度
 */
- (CGFloat)zj_tableView:(UITableView *)tableView
     cellWithIdentifier:(NSString *)identifier
              indexPath:(NSIndexPath *)indexPath;


/**
 获取指定Cell 的height

 @param  tableView tableView
 @param  cell 对应的Cell
 @return cell高度
 */
- (CGFloat)zj_tableView:(UITableView *)tableView
             cellHeight:(UITableViewCell *)cell;

/**
 根据ID 重用cell
 
 @param tableView tableView
 @param identifier identifier
 @param indexPath indexPath
 @return cell
 */
- (UITableViewCell *)zj_tableView:(UITableView *)tableView
          cellForRowWithIentifier:(NSString *)identifier
                        indexPath:(NSIndexPath *)indexPath;


/**
 配置对应IndexPath下的cell内容
 
 @param tableView tableView
 @param currentCell 对应的cell
 @param indexPath indexPath
 */
- (void)zj_tableView:(UITableView *)tableView
       configureCell:(UITableViewCell *)currentCell
           indexPath:(NSIndexPath *)indexPath;







@end

NS_ASSUME_NONNULL_END
