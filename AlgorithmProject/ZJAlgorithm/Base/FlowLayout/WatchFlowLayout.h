//
//  WatchFlowLayout.h
//  RecordFlowLayout
//
//  Created by leelisey on 2018/2/26.
//  Copyright © 2018年 leelisey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WatchFlowLayoutDelegate <NSObject>

@optional

- (CGFloat)minimumLineSpacingForSectionAtIndex:(NSInteger)section;  // 行间距
- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section; // 列间距
- (UIEdgeInsets)contentInsetOfSectionAtIndex:(NSInteger)section;        // sectionInset

@required

- (NSInteger)numberOfSection;   // section的数量
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;  // cell的大小
- (NSInteger)numberOfColumnInSectionAtIndex:(NSInteger)section; // section的列数

@end

@interface WatchFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WatchFlowLayoutDelegate> flowDelegate;

@property (nonatomic, assign) UIEdgeInsets contentInset;    // 代替collectionView.contentInset

@end
