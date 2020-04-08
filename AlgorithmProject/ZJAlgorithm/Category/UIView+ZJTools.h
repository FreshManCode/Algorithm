//
//  UIView+ZJTools.h
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/8.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZJTapGesture)(UITapGestureRecognizer *gesture);

@interface UIView (ZJTools)


/**
 添加点击手势(单击)

 @param gesture 点击回调
 */
- (void)addTapGesture:(ZJTapGesture)gesture;


/**
 添加双击手势(双击)

 @param gesture 点击回调
 */
- (void)addDoubleTapGesture:(ZJTapGesture)gesture;


@end

NS_ASSUME_NONNULL_END
