//
//  ZJBaseView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseView.h"

@implementation ZJBaseView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self zj_addSubviews];
        [self zj_addConstraints];
    }
    return self;
}

- (void)zj_addSubviews {
    
}

- (void)zj_addConstraints {
    
}


@end
