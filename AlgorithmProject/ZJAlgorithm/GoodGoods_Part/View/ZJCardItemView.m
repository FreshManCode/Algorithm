//
//  ZJCardItemView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJCardItemView.h"
#import "ZJGoodsTableHeadResModel.h"
#import "UIImageView+ZJCacheImageView.h"

@interface ZJCardItemView ()

@property (nonatomic, strong) UILabel *tagLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *discountPriceLab;
@property (nonatomic, strong) YYAnimatedImageView *logoView;

@end

@implementation ZJCardItemView

- (void)zj_addSubviews {
    self.tagLab = ZJ_LeftAlignmentLabel(ZJBFont(16.f), [UIColor blackColor]);
    [self addSubview:self.tagLab];
    
    self.priceLab = ZJ_LeftAlignmentLabel(ZJFont(14.f), [UIColor redColor]);
    [self addSubview:self.priceLab];
    
    self.discountPriceLab = ZJ_LeftAlignmentLabel(ZJFont(13.f), [UIColor lightGrayColor]);
    [self addSubview:self.discountPriceLab];
    
    self.logoView = [YYAnimatedImageView new];
    [self addSubview:self.logoView];
}

- (void)zj_addConstraints {
    [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self.discountPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagLab);
        make.bottom.mas_equalTo(-5);
        make.right.equalTo(self.logoView.mas_left).offset(-5);
    }];
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.discountPriceLab);
        make.bottom.equalTo(self.discountPriceLab.mas_top).offset(-5);
    }];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLab.mas_bottom);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

- (void)setDynamicListItemModel:(ZJGoodsTableHeadDynamicListsModel *)model {
//    "icon_type": "money",
//    "color": "F75026",
//    "first_text": "¥",
//    "middle_text": "13088",
//    "last_text": "",
//    "sub_text": "差价112元"
    ZJGoodsTableHeadDynamicTextItemModel *info = model.text_info;
    [self.tagLab setText:model.name];
    [self.priceLab setText:[NSString stringWithFormat:@"%@%@",info.first_text,info.middle_text]];
    [self.discountPriceLab setText:info.sub_text];
    [self.priceLab setTextColor:ZJColorWithString(info.color)];
    [self.logoView zj_imageWithURL:model.cover placeHolder:ZJDefaultPlahoder()];
}

- (void)setTestContent {
    [self.tagLab setText:@"最新降价"];
    [self.priceLab setText:@"¥9638"];
    [self.discountPriceLab setText:@"降价920元"];
    [self.logoView setBackgroundColor:[UIColor yellowColor]];
}

@end
