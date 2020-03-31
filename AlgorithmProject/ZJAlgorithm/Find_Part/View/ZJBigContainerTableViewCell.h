//
//  ZJBigContainerTableViewCell.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class SDCycleScrollView;

@interface ZJBigContainerTableViewCell : ZJBaseTableViewCell

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;

- (void)setBanners:(NSArray<NSString *> *)bannerImage;


@end

NS_ASSUME_NONNULL_END
