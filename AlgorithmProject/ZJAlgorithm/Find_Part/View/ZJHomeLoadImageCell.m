//
//  ZJHomeLoadImageCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHomeLoadImageCell.h"
#import "ZJDiscoverlistItemModel.h"
#import "UIView+Constraints.h"
#import "UIImageView+ZJCacheImageView.h"
#import "ZJLibsHeader.h"


@interface ZJHomeLoadImageCell ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) YYAnimatedImageView *imageView;

@end

@implementation ZJHomeLoadImageCell


- (void)zj_addSubviews {
    self.containerView = [UIView new];
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.imageView];
}

- (void)zj_addConstraints {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)setListItemModel:(ZJDiscoverlistItemModel *)itemModel
          collectionView:(UICollectionView *)collectionView {
    [self setListItemModel:itemModel];
}

- (void)setListItemModel:(ZJDiscoverlistItemModel *)itemModel {
    
    [self.imageView zj_imageWithURL:itemModel.pic_url
                        placeHolder:ZJ_LoadImage(@"placeholder")];
    
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [YYAnimatedImageView new];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
}


@end


