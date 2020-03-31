//
//  ZJRequestCache.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AFHTTPSessionManager;

@interface ZJRequestCache : NSObject
/**是否开启缓存*/
@property (nonatomic, assign,getter=isOepnCache) BOOL openCache;
/**
 归档response 到本地

 @param data 数据
 @param key key
 @return 是否成功
 */
- (BOOL)storeData:(NSDictionary *)data key:(NSString *)key;

/**
 根据key 去获取数据

 @param key key
 @return response
 */
- (NSDictionary *)dataForKey:(NSString *)key;

/**
 往header里面添加Cookie

 @param manager 对应的实例变量
 */
- (void)addCookieToHeader:(AFHTTPSessionManager *)manager;

/**
 保存response的cookie

 @param headers headers
 */
- (void)storeCookieWithHeader:(NSDictionary *)headers;

@end

NS_ASSUME_NONNULL_END
