//
//  ZJTwoImageCardCollectionCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJTwoImageCardCollectionCell.h"
#import "ZJCardItemView.h"

@interface ZJTwoImageCardCollectionCell ()

@property (nonatomic, strong) ZJCardItemView *leftCardView;
@property (nonatomic, strong) ZJCardItemView *rightCardView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation ZJTwoImageCardCollectionCell

- (void)zj_addSubviews {
    self.leftCardView = [ZJCardItemView new];
    [self.contentView addSubview:self.leftCardView];
    
    self.rightCardView = [ZJCardItemView new];
    [self.contentView addSubview:self.rightCardView];
    
    self.lineView = [UIView new];
    [self.lineView setBackgroundColor:ZJECLineColor];
    [self.contentView addSubview:self.lineView];
    
}

- (void)setDynamicListsModel:(NSArray <ZJGoodsTableHeadDynamicListsModel *> *)listsModel {
    for (int i = 0 ; i < listsModel.count; i ++) {
        if (i == 0) {
            [self.leftCardView setDynamicListItemModel:listsModel[i]];
        }
        else if (i == 1) {
            [self.rightCardView setDynamicListItemModel:listsModel[i]];
        }
    }
}

- (void)zj_addConstraints {
    [self.leftCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.right.equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.rightCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.left.equalTo(self.contentView.mas_centerX).offset(10);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
    }];
}

@end
