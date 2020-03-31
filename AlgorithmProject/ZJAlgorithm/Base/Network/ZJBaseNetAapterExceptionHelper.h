//
//  ZJBaseNetAapterExceptionHelper.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseNetAapterExceptionHelper : NSObject

+ (ZJBaseNetAapterExceptionHelper *)helper;

/**
 入栈 adapter
 
 @param adapter  adapter
 */
- (void)pushAdapter:(NSObject *)adapter;

/**
 出栈 adapter
 
 @param adapter adapter
 */
- (void)popAdapter:(NSObject *)adapter;

/**
 adapter 是否存在
 
 @param adapter adapter
 @return YES/NO
 */
- (BOOL)adapterIsExited:(NSObject *)adapter;

/**
 清除adapter 缓存
 */
- (void)clearAdapterArray;

// 是否处于异常状态
- (BOOL)isInExceptionStatus;

- (void)enterExceptionStatus;

- (void)leaveExceptionStatus;

@end

NS_ASSUME_NONNULL_END
