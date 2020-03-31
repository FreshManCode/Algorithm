//
//  ZJTimerManager.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  定时器管理器用来解除与target 循环引用

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJTimerManager;

@protocol ZJTimerManagerDelegate <NSObject>

- (void)timerManager:(ZJTimerManager *)manager
       didUpdateTime:(NSTimeInterval)remainTime;

@end



@interface ZJTimerManager : NSObject

{
    struct {
        unsigned int ZJTimerManagerDelegate : 1;
    }_DelegateFlags;
}

@property (nonatomic,weak) id <ZJTimerManagerDelegate> delegate;

@property (nonatomic, assign) NSInteger maxTime;
@property (nonatomic, assign) NSTimeInterval timeGap;

/**
 创建的单例类对象
 
 @return 实例对象
 */
+ (instancetype)timerManager;


+ (instancetype)createTimerWithMaxTime:(NSInteger )maxTime
                               timeGap:(NSTimeInterval)timeGap;

- (void)timerFire;

- (void)timeStop;

- (void)timePause;

+ (void)destoryTimer;


@end

NS_ASSUME_NONNULL_END
