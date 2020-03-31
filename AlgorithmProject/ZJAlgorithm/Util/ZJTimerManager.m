//
//  ZJTimerManager.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJTimerManager.h"

@interface ZJTimerManager ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger remianTime;

@end


@implementation ZJTimerManager


static ZJTimerManager *timerManager = nil;
+ (instancetype)createTimerWithMaxTime:(NSInteger )maxTime
                               timeGap:(NSTimeInterval)timeGap {
    ZJTimerManager *timerManager = [[ZJTimerManager alloc] initWithTimeGap:timeGap];
    timerManager.maxTime = maxTime ;
    timerManager.timeGap = timeGap;
    return timerManager;
}

+ (instancetype)timerManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerManager = [[self alloc] init];
    });
    return timerManager;
}

- (id)init {
    if (self = [super init]) {
        [self addTimerWithTimeGap:1.f];
    }
    return self;
}

- (id)initWithTimeGap:(NSTimeInterval)timeGap {
    if (self = [super init]) {
        [self addTimerWithTimeGap:timeGap];
    }
    return self;
}

- (void)setDelegate:(id<ZJTimerManagerDelegate>)delegate {
    _delegate = delegate;
    _DelegateFlags.ZJTimerManagerDelegate = _delegate && [_delegate respondsToSelector:@selector(timerManager:didUpdateTime:)];
}

- (void)setMaxTime:(NSInteger)maxTime {
    _maxTime = maxTime;
    [self setRemianTime:maxTime];
}

- (void)addTimerWithTimeGap:(NSTimeInterval)timeGap {
    NSTimeInterval interVal = timeGap > 0.f ? timeGap : 1.f;
    _timeGap = interVal;
    [self resetTime];
    _timer = [self createTimer];
}
- (void)setTimeGap:(NSTimeInterval)timeGap {
    _timeGap = timeGap;
    [self addTimerWithTimeGap:timeGap];
}

- (void)timeCountDown:(NSTimer *)time {
    self.remianTime --;
    if (self.remianTime <=0) {
        self.remianTime = 0;
    }
    if (_DelegateFlags.ZJTimerManagerDelegate) {
        [_delegate timerManager:self didUpdateTime:self.remianTime];
    }
}

- (NSTimer *)createTimer {
    NSTimer *timer  = [NSTimer timerWithTimeInterval:self.timeGap target:self selector:@selector(timeCountDown:) userInfo:nil repeats:true];
    //  关闭定时器
    timer.fireDate = [NSDate distantFuture];
    return timer;
}


- (void)timerFire {
    if (!_timer) {
        _timer = [self createTimer];
    }
    //  开启定时器
    [_timer setFireDate:[NSDate distantPast]];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timeStop {
    [self resetTime];
}


- (void)resetTime {
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)timePause {
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

+ (void)destoryTimer {
    timerManager = nil;
}


@end
