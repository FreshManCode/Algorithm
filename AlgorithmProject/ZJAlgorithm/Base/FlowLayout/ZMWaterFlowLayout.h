//
//  ZMWaterFlowLayout.h
//  WaterFlowDemo
//
//  Created by ZM on 2018/10/15.
//  Copyright © 2018年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class ZMWaterFlowLayout;
@protocol ZMWaterFlowLayoutDelegate <NSObject>
//@required
///**
// 获取itemCell的高度
// @param layout      瀑布流
// @param index       cell的索引
// @param itemWidth   cell的宽度
// @return cell的高度
// */
//- (CGFloat)zm_waterflowLayout:(ZMWaterFlowLayout *)layout atIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional
/**瀑布流的列数*/
- (NSInteger)zm_columnCountInLayout:(ZMWaterFlowLayout *)layout;
/**每一列之间的间距*/
- (CGFloat)zm_columnMarginInLayout:(ZMWaterFlowLayout *)layout;
/**每一行之间的间距*/
- (CGFloat)zm_rowMarginInLayout:(ZMWaterFlowLayout *)layout;
/**cell边缘的间距*/
- (UIEdgeInsets)zm_edgeInsetsInLayout:(ZMWaterFlowLayout *)layout;
@end



@interface ZMWaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak, nullable) id<UICollectionViewDelegateFlowLayout> delegate;
@property (nonatomic, strong) NSMutableDictionary *attributeDic; //存放item的位置信息
@property (nonatomic, strong) NSMutableArray *columnHeightArray; //存放每一个列的高度的数组

@property (nonatomic,assign) NSInteger columnCount;
@property (nonatomic,assign) CGFloat lineSpacing;
@property (nonatomic,assign) CGFloat columnMargin;
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
@property (nonatomic,assign) NSInteger waterFlowSection;
@property (nonatomic, weak) id<ZMWaterFlowLayoutDelegate> zmDelegate;



@end

NS_ASSUME_NONNULL_END
