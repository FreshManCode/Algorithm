//
//  ZJNavBarView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJNavBarView.h"

@implementation ZJNavBarView

- (void)zj_addSubviews {
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setBackgroundImage:ZJ_LoadImage(@"zj_back_icon_normal") forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:ZJ_LoadImage(@"zj_back_icon_normal") forState:UIControlStateSelected];
    [self addSubview:_leftButton];
    
    _titleLab = ZJ_CenterAlignmentLabel(ZJ_Font(18),ZJColorWithHex(0x000000));
    [self addSubview:_titleLab];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_rightButton];
    
    _sepratorLine = [UIView new];
    [_sepratorLine setHidden:true];
    [_sepratorLine setBackgroundColor:ZJECLineColor];
    [self addSubview:_sepratorLine];
}

- (void)zj_addConstraints {
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.rightButton  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLab  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(self.leftButton.mas_right).offset(5);
        make.right.lessThanOrEqualTo(self.rightButton.mas_left).offset(-5);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.sepratorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.8f);
        make.bottom.mas_equalTo(0);
    }];
}



@end
