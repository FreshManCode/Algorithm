//
//  ZJSortHeaderView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJSortHeaderView.h"
#import "YLButton.h"

@interface ZJSortHeaderView ()

@property (nonatomic, strong) YLButton *hotButton;
@property (nonatomic, strong) YLButton *filterButton;

@end

@implementation ZJSortHeaderView

static CGFloat const kButtonW = 120.f;
static CGFloat const kButtonH = 20.f;

- (void)zj_addSubviews {
    self.hotButton = [self createWithTitle:@"热门排序"
                               normalImage:@"TriangleDown"
                             selectedImage:@"TriangleUp"];
    [self.hotButton addTarget:self action:@selector(hotEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.hotButton];
    
    self.filterButton = [self createWithTitle:@"筛选商品"
                                  normalImage:@"Filter"
                                selectedImage:@"Filter"];
    [self.filterButton addTarget:self action:@selector(filterEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.filterButton];
}

- (void)zj_addConstraints {
    [self layoutIfNeeded];
    CGFloat width = CGRectGetWidth(self.frame);
    [self.hotButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-(width/2.0 - kButtonW)/2.0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kButtonW, kButtonH));
    }];
    
    [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset((width/2.0 - kButtonW)/2.0);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kButtonW, kButtonH));
    }];
}

- (void)hotEvent:(YLButton *)button {
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(sortView:didClickIndex:isOpen:)]) {
        [_delegate sortView:self didClickIndex:0 isOpen:button.selected];
    }
}

- (void)filterEvent:(YLButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(sortView:didClickIndex:isOpen:)]) {
        [_delegate sortView:self didClickIndex:1 isOpen:true];
    }
}

/**恢复默认状态*/
- (void)resetDefaultState {
    [self.filterButton setSelected:false];
    [self.hotButton setSelected:false];
}

- (void)updateLeftTitle:(NSString *)aLeft {
    [self.hotButton setTitle:aLeft forState:UIControlStateNormal];
    CGFloat newTilteW = [self getNormalWidthWithContent:aLeft];
    self.hotButton.titleRect = CGRectMake(0, 0, newTilteW, 20);
    self.hotButton.imageRect = CGRectMake(newTilteW, 5, 10, 10);
}

- (void)updateRightTitle:(NSString *)aRight {
    [self.filterButton setTitle:aRight forState:UIControlStateNormal];
}


- (YLButton *)createWithTitle:(NSString *)title
                  normalImage:(NSString *)normal
                selectedImage:(NSString *)selected {
    YLButton *button = [YLButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.adjustsFontSizeToFitWidth = true;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:ZJ_LoadImage(normal) forState:UIControlStateNormal];
    [button setImage:ZJ_LoadImage(selected) forState:UIControlStateSelected];
    button.titleLabel.font = ZJFont(15.f);
    button.titleRect = CGRectMake(0, 0, 70, 20);
    button.imageRect = CGRectMake(70, 5, 10, 10);
    return button;
}

- (CGFloat)getNormalWidthWithContent:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(kButtonW - 10, 20)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:ZJFont(15.f)}
                                        context:nil
                   ];
    return ceilf(rect.size.width);
}


@end
