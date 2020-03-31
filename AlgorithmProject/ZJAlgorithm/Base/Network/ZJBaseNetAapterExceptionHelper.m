//
//  ZJBaseNetAapterExceptionHelper.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseNetAapterExceptionHelper.h"

@interface ZJBaseNetAapterExceptionHelper ()

@property (nonatomic, strong) NSMutableArray *adapterArray;
@property (nonatomic, assign) BOOL bGlobalException;

@end

@implementation ZJBaseNetAapterExceptionHelper

+ (ZJBaseNetAapterExceptionHelper *)helper {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _adapterArray = [NSMutableArray array];
        _bGlobalException = NO;
    }
    return self;
}

- (void)pushAdapter:(NSObject *)adapter {
    [_adapterArray addObject:adapter];
}

- (void)popAdapter:(NSObject *)adapter {
    [_adapterArray removeObject:adapter];
}

- (BOOL)adapterIsExited:(NSObject *)adapter {
    if ([_adapterArray indexOfObject:adapter] == NSNotFound) {
        return false;
    }
    return true;
}

- (void)clearAdapterArray {
    [_adapterArray removeAllObjects];
}

- (BOOL)isInExceptionStatus {
    return _bGlobalException;
}

- (void)enterExceptionStatus {
    _bGlobalException = true;
}

- (void)leaveExceptionStatus {
    _bGlobalException = false;
}



@end


