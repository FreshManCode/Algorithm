//
//  ZJImageTagCollectionCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJImageTagCollectionCell.h"
#import "ZJHorizontalCollectionContainerView.h"

@interface ZJImageTagCollectionCell ()

@property (nonatomic, strong) ZJHorizontalCollectionContainerView *tagCollectionView;

@end



@implementation ZJImageTagCollectionCell


- (void)zj_addSubviews {
    self.tagCollectionView = [ZJHorizontalCollectionContainerView new];
    [self addSubview:self.tagCollectionView];
}

- (void)zj_addConstraints {
    [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-5);
    }];
}

- (void)setGoodsCategoryListsModel:(NSArray <ZJGoodsTableHeadCategoryListModel *> *)lists {
    [self.tagCollectionView setCategoryListsModel:lists];
}


@end
