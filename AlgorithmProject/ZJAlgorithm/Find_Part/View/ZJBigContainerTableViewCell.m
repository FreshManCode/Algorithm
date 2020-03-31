//
//  ZJBigContainerTableViewCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBigContainerTableViewCell.h"
#import <SDCycleScrollView.h>

@interface ZJBigContainerTableViewCell ()  <SDCycleScrollViewDelegate>

@end

@implementation ZJBigContainerTableViewCell

- (void)zj_addSubviews {
    self.containerView = [UIView new];
    self.containerView.layer.cornerRadius = 4.f;
    self.containerView.clipsToBounds = true;
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
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(140.f);
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
