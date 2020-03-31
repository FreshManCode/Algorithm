//
//  ZJCycleLoopCollectionViewCell.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//
#import "ZJCycleLoopCollectionViewCell.h"

#import <SDCycleScrollView.h>
#import "ZJLibsHeader.h"
#import "ZJGoodsTableHeadResModel.h"


@interface ZJCycleLoopCollectionViewCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleView;

@end


@implementation ZJCycleLoopCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _cycleView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_cycleView setDelegate:self];
        [_cycleView setPlaceholderImage:ZJ_LoadImage(@"placeholder")];
        _cycleView.scrollDirection     = UICollectionViewScrollDirectionHorizontal;
        _cycleView.currentPageDotImage = ZJ_LoadImage(@"pageControlCurrentDot");
        _cycleView.pageDotImage = ZJ_LoadImage(@"pageControlDot");
        _cycleView.layer.cornerRadius = 5.f;
        _cycleView.clipsToBounds = true;
        [self addSubview:self.cycleView];
        [self p_addConstraints];
    }
    return self;
}

- (void)p_addConstraints {
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index {
    if ([_delegate respondsToSelector:@selector(cycyleLoopCell:didClickIndex:)]) {
        [_delegate cycyleLoopCell:self didClickIndex:index];
    }
}

- (void)setBanners:(NSArray<NSString *> *)bannerImages {
    if (bannerImages.count > 0) {
        [self.cycleView setImageURLStringsGroup:bannerImages];
    }
}

- (void)setBannerModelLists:(NSArray <ZJGoodsTableHeadBannerListModel *> *)lists {
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:lists.count];
    for (ZJGoodsTableHeadBannerListModel * itemModel in lists) {
        [tempArray addObject:itemModel.pic];
    }
    [self.cycleView setImageURLStringsGroup:tempArray];
}


@end
