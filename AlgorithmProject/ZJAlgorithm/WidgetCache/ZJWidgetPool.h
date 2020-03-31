//
//  ZJWidgetPool.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJWidgetPoolHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJWidgetPool : NSObject

/**
 查找缓存池中的 格式化日期实例
 
 @param formatterKey key
 @return 实例对象
 */
+ (NSDateFormatter *)dateFormatterForKey:(NSString *)formatterKey;


/**
 查找缓存池中的 小数格式处理实例
 
 @param formatterKey key
 @return 实例对象
 */
+ (NSNumberFormatter *)numberFormatterForKey:(NSString *)formatterKey;


/**
 保存实例到缓存池中
 
 @param object 对象
 @param key key
 */
+ (void)setObjcet:(id)object key:(NSString *)key;


/**
 从缓存池中获取一个对象
 
 @param key key
 @return 获取的对象实例
 */
+ (id)cacheValueForKey:(NSString *)key;


/**
 清除所有缓存对象
 */
+ (void)removeAllCacheObject;



@end

NS_ASSUME_NONNULL_END
