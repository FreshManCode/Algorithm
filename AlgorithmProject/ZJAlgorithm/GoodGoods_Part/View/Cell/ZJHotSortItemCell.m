//
//  ZJHotSortItemCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/1.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHotSortItemCell.h"

@interface ZJHotSortItemCell ()

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *checkImageView;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;


@end

@implementation ZJHotSortItemCell

- (void)zj_addSubviews {
    self.normalColor   = [UIColor lightGrayColor];
    self.selectedColor = [UIColor blackColor];
    
    self.nameLab = ZJ_LeftAlignmentLabel(ZJFont(15.f), self.normalColor);
    [self.contentView addSubview:self.nameLab];
    
    self.checkImageView = [UIImageView new];
    self.checkImageView.image = ZJ_LoadImage(@"CheckMark");
    self.checkImageView.hidden = true;
    [self.contentView addSubview:self.checkImageView];
}

- (void)zj_addConstraints {
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}


- (void)setTitle:(NSString *)title
        selected:(BOOL)isSelected {
    [self.nameLab setText:title];
    [self.nameLab setTextColor:isSelected ?self.selectedColor : self.normalColor ];
    self.checkImageView.hidden = !isSelected;
}

@end
