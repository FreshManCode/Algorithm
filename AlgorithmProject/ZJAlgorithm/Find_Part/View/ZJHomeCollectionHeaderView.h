//
//  ZJHomeCollectionHeaderView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  首页滑动轮播图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJHomeCollectionHeaderView;
@protocol ZJHomeCollectionHeaderViewDelegate <NSObject>

- (void)loopHeaderView:(ZJHomeCollectionHeaderView *)headerView
         didClickIndex:(NSInteger)index;

@end

@interface ZJHomeCollectionHeaderView : UICollectionReusableView

@property (nonatomic,weak) id <ZJHomeCollectionHeaderViewDelegate> delegate;


- (void)setBanners:(NSArray <NSString *> *)bannerImages;



@end

NS_ASSUME_NONNULL_END
