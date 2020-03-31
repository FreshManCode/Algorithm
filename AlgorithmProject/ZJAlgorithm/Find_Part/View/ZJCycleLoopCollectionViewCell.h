//
//  ZJCycleLoopCollectionViewCell.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJGoodsTableHeadBannerListModel;
@class ZJCycleLoopCollectionViewCell;

@protocol ZJCycleLoopCollectionViewCellDelegate <NSObject>
- (void)cycyleLoopCell:(ZJCycleLoopCollectionViewCell*)loopCell
         didClickIndex:(NSInteger)index;
@end


static NSString * const kCycyleCollectionCellID = @"ZJCycleLoopCollectionViewCellID";


@interface ZJCycleLoopCollectionViewCell : UICollectionViewCell

@property (nonatomic,weak) id <ZJCycleLoopCollectionViewCellDelegate> delegate;


- (void)setBanners:(NSArray <NSString *> *)bannerImages;

- (void)setBannerModelLists:(NSArray <ZJGoodsTableHeadBannerListModel *> *)lists;

@end

NS_ASSUME_NONNULL_END
