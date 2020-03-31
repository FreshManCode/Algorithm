//
//  ZJCategoryView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ZJCategoryViewAlignment) {
    ZJCategoryViewAlignmentLeft,
    ZJCategoryViewAlignmentCenter,
    ZJCategoryViewAlignmentRight
};

@interface ZJCategoryViewCell : UICollectionViewCell

@property (nonatomic, readonly, strong) UILabel *titleLabel;

@end;



@interface ZJCategoryView : ZJBaseView
/**(ZJCategoryView 实例对象)默认高度*/
@property (nonatomic, assign) CGFloat categoryViewDefaultHeight;

/**item 右边间距 默认为100*/
@property (nonatomic, assign) CGFloat categoryViewRightGap;

/// titles
@property (nonatomic, copy) NSArray<NSString *> *titles;

/// 分布方式（左、中、右）
@property (nonatomic) ZJCategoryViewAlignment alignment;

/// 游标
@property (nonatomic, strong, readonly) UIView *vernier;

/// 上边框
@property (nonatomic, strong, readonly) UIView *topBorder;

/// 下边框
@property (nonatomic, strong, readonly) UIView *bottomBorder;

/// 未选中时的字体大小
@property (nonatomic, strong) UIFont *titleNomalFont;

/// 选中时的字体大小
@property (nonatomic, strong) UIFont *titleSelectedFont;

/// 未选中时的字体颜色
@property (nonatomic, strong) UIColor *titleNormalColor;

/// 选中时的字体颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;

/// 初始选中的下标
@property (nonatomic) NSInteger originalIndex;

/// 当前选中的下标
@property (nonatomic, readonly) NSInteger selectedIndex;

/// 自身高度
@property (nonatomic) CGFloat height;

/// 游标的高度
@property (nonatomic) CGFloat vernierHeight;

/// 固定游标的宽度，默认是不固定的
@property (nonatomic) CGFloat vernierWidth;

/// item间距
@property (nonatomic) CGFloat itemSpacing;
/// item宽度
@property (nonatomic, assign) CGFloat itemWidth;
//item 正常时候的宽度
@property (nonatomic, assign) CGFloat itemNormalWidth;


/// collectionView左右的margin
@property (nonatomic) CGFloat leftAndRightMargin;

/// item是否等分(实质上改变的是itemWidth)，Default：NO
@property (nonatomic) CGFloat isEqualParts;

/// 字体变大、vernier位置切换动画时长，default：0.1
@property (nonatomic) CGFloat animateDuration;

/// item点击事件的回调
@property (nonatomic, copy) void (^selectedItemHelper)(NSUInteger index);


/**
 使collectionView滚动到指定的cell
 
 @param targetIndex 目标cell的index
 @param sourceIndex 当前cell的index
 @param percent 滑动距离/(sourceIndex与targetIndex的距离)
 */
- (void)scrollToTargetIndex:(NSUInteger)targetIndex
                sourceIndex:(NSUInteger)sourceIndex
                    percent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
