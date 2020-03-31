//
//  ZJFlowLayoutCell.h
//  ImitateBaiduCourse
//
//  Created by 张君君 on 2019/10/23.
//  Copyright © 2019年 ZhangJunJun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseCollectionViewCell.h"

@class ITRowModel;
@class YYLabel;
@class ZJDiscoverlistItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface ZJFlowLayoutCell : ZJBaseCollectionViewCell

@property (nonatomic, strong) YYLabel *nameLab;
@property (nonatomic, strong) YYLabel *contentLab;

- (void)setRowModel:(ITRowModel *)model;

- (void)setListItemModel:(ZJDiscoverlistItemModel *)itemModel;

@end

NS_ASSUME_NONNULL_END
