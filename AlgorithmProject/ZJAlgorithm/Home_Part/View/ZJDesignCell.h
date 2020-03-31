//
//  ZJDesignCell.h
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/30.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const kDesignCellID  = @"ZJDesignCellID";


@interface ZJDesignCell : ZJBaseTableViewCell

@property (nonatomic, strong) UILabel *nameLab;


- (void)setText:(NSString *)text;

@end



NS_ASSUME_NONNULL_END
