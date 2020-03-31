//
//  ZJDesignCell.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/30.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJDesignCell.h"

@implementation ZJDesignCell

- (void)zj_addSubviews {
    self.nameLab = ZJ_LeftAlignmentLabel(ZJ_PSFont(15.f), ZJ9BTitleColor);
    [self.contentView addSubview:self.nameLab];
    [self setSepratorType:ZJCellSepratorBottom];
}

- (void)zj_addConstraints {
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
}

- (void)setText:(NSString *)text {
    [self.nameLab setText:text];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
