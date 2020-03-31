//
//  ZJWaitHUDView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJWaitHUDView.h"
#import "SCGIFImageView.h"

static ZJWaitHUDView* globalWexWaitHudView = nil;

@interface ZJWaitHUDView ()
@property (nonatomic, strong) ZJBaseView *frameView;
@end


@implementation ZJWaitHUDView

+ (void)show:(UIView *)parentView {
    if (!globalWexWaitHudView ) {
        globalWexWaitHudView = [[ZJWaitHUDView alloc] init];
    }
    [globalWexWaitHudView initControlWithParentView:parentView];
}

+ (void)show {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [self show:window];
}

+ (void)hide {
    if (globalWexWaitHudView) {
        [globalWexWaitHudView removeFromSuperview];
        globalWexWaitHudView = nil;
    }
}


- (void)initControlWithParentView:(UIView*)parentView {
    [parentView addSubview:self];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(parentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // _frameView
    _frameView = [[ZJBaseView alloc] init];
    [self addSubview:_frameView];
    
    _frameView.backgroundColor = [UIColor clearColor];
    
    // 设置圆角
    CALayer* layer = _frameView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 5;
    
    [_frameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    SCGIFImageView *iconGifImageView = [[SCGIFImageView alloc] init];
    [_frameView addSubview:iconGifImageView];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"wait-icon-gif.gif" ofType:nil];
    NSData* imageData  = [NSData dataWithContentsOfFile:filePath];
    [iconGifImageView setData:imageData];
    iconGifImageView.animating = YES;
    
    [iconGifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.frameView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}


@end
