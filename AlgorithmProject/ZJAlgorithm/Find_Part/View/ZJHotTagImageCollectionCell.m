//
//  ZJHotTagImageCollectionCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHotTagImageCollectionCell.h"
#import <YYKit.h>
#import "UIImageView+ZJCacheImageView.h"
#import "ZJGoodsTableHeadResModel.h"

@interface ZJHotTagImageCollectionCell ()

@property (nonatomic, strong) YYAnimatedImageView  *goosImageView;

@property (nonatomic, strong) UILabel *goodsNameLab;

@end

@implementation ZJHotTagImageCollectionCell

- (void)zj_addSubviews {
    [self.contentView addSubview:self.goosImageView];
    [self.contentView addSubview:self.goodsNameLab];
    [self.contentView setBackgroundColor:ZJECLineColor];
}

- (void)zj_addConstraints {
    [self.goosImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    [self.goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goosImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
    }];
}

/**
 好货 页面
 
 @param categoryModel model
 */
- (void)setGoodsCategoryModel:(ZJGoodsTableHeadCategoryListModel *)categoryModel {
    [self.goodsNameLab setText:categoryModel.name];
    [self.goosImageView zj_imageWithURL:categoryModel.cover placeHolder:ZJ_LoadImage(@"placeholder")];
}

- (YYAnimatedImageView *)goosImageView{
    if(!_goosImageView){
        _goosImageView = [YYAnimatedImageView new];
    }
    return _goosImageView;
}


- (UILabel *)goodsNameLab{
    if(!_goodsNameLab){
        _goodsNameLab = ZJ_CenterAlignmentLabel(ZJFont(14.f), [UIColor lightGrayColor]);
        [_goodsNameLab setText:@"秋冬新品"];
    }
    return _goodsNameLab;
}



@end
