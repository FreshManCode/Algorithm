//
//  ZJHotSortItemCell.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/1.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
static NSString * const kHotSortItemCellID = @"ZJHotSortItemCellID";


@interface ZJHotSortItemCell : ZJBaseTableViewCell

- (void)setTitle:(NSString *)title
        selected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
