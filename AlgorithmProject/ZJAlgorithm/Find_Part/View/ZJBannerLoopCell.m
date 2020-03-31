//
//  ZJBannerLoopCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBannerLoopCell.h"
#import <SDCycleScrollView.h>

@interface ZJBannerLoopCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;


@end

@implementation ZJBannerLoopCell

- (void)zj_addSubviews {
    self.containerView = [UIView new];
    [self.contentView addSubview:self.containerView];
    
    _cycleView = [SDCycleScrollView new];
    [_cycleView setDelegate:self];
    [_cycleView setPlaceholderImage:ZJ_LoadImage(@"placeholder")];
    _cycleView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _cycleView.currentPageDotImage = ZJ_LoadImage(@"pageControlCurrentDot");
    _cycleView.pageDotImage = ZJ_LoadImage(@"pageControlDot");
    [self.containerView addSubview:self.cycleView];
}

- (void)zj_addConstraints {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
}

- (void)setBanners:(NSArray<NSString *> *)bannerImages {
    if (bannerImages.count > 0) {
        [self.cycleView setImageURLStringsGroup:bannerImages];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
