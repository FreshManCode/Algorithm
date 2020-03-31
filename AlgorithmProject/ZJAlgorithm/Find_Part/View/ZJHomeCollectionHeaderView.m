//
//  ZJHomeCollectionHeaderView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHomeCollectionHeaderView.h"
#import <SDCycleScrollView.h>
#import "ZJLibsHeader.h"

@interface ZJHomeCollectionHeaderView () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleView;

@end

@implementation ZJHomeCollectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(15, 0, ZJScreenWidth - 15 * 2, 140.f)];
        [_cycleView setDelegate:self];
        [_cycleView setPlaceholderImage:ZJ_LoadImage(@"placeholder")];
        _cycleView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _cycleView.currentPageDotImage = ZJ_LoadImage(@"pageControlCurrentDot");
        _cycleView.pageDotImage = ZJ_LoadImage(@"pageControlDot");
        [self addSubview:self.cycleView];

    }
    return self;
}

- (void)setBanners:(NSArray<NSString *> *)bannerImages {
    if (bannerImages.count > 0) {
        [self.cycleView setImageURLStringsGroup:bannerImages];
    }
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index {
    if ([_delegate respondsToSelector:@selector(loopHeaderView:didClickIndex:)]) {
        [_delegate loopHeaderView:self didClickIndex:index];
    }
}


@end
