//
//  ZJNavBarView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseView.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZJNavBarType) {
    ZJNavBarDefault = 0, //back + title
    ZJNavBarNone    = 1,//没有导航栏
    ZJNavBarHideLeftButton=2,//隐藏左边返回按钮
};

@interface ZJNavBarView : ZJBaseView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *sepratorLine;


@end

NS_ASSUME_NONNULL_END
