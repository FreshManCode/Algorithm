//
//  ZJSortHeaderView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseView.h"

NS_ASSUME_NONNULL_BEGIN


@class ZJSortHeaderView;

@protocol ZJSortHeaderViewDelegate <NSObject>

- (void)sortView:(ZJSortHeaderView *)sortView
   didClickIndex:(NSInteger)clickIndex
          isOpen:(BOOL)isOpen;

@end

@interface ZJSortHeaderView : ZJBaseView

@property (nonatomic,weak) id <ZJSortHeaderViewDelegate> delegate;


/**恢复默认状态*/
- (void)resetDefaultState;

- (void)updateLeftTitle:(NSString *)aLeft;

- (void)updateRightTitle:(NSString *)aRight;


@end

NS_ASSUME_NONNULL_END
