//
//  ZJWidgetPool.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJWidgetPool.h"

@implementation ZJWidgetPool

static NSCache *_cachePool;

+ (void)initialize {
    _cachePool = [[NSCache alloc] init];
    //  最大缓存空间 5M
    [_cachePool setTotalCostLimit:1024 * 1024 * 5];
}

/**
 查找缓存池中的 格式化日期实例
 
 @param formatterKey key
 @return 实例对象
 */
+ (NSDateFormatter *)dateFormatterForKey:(NSString *)formatterKey {
    NSDateFormatter *formatter = [_cachePool objectForKey:formatterKey];
    if (!formatter) {
        formatter = [self createDateFormatterWithKey:formatterKey];
        [self setObjcet:formatter key:formatterKey];
    }
    return formatter;
}

/**
 查找缓存池中的 小数格式处理实例
 
 @param formatterKey key
 @return 实例对象
 */
+ (NSNumberFormatter *)numberFormatterForKey:(NSString *)formatterKey {
    NSNumberFormatter *numberFormatter = [_cachePool objectForKey:formatterKey];
    if (!numberFormatter) {
        numberFormatter = [self createNumberFormatterWithKey:formatterKey];
        [self setObjcet:numberFormatter key:formatterKey];
    }
    return numberFormatter;
}

/**
 保存实例到缓存池中
 
 @param object 对象
 @param key key
 */
+ (void)setObjcet:(id)object key:(NSString *)key {
    [_cachePool setObject:object forKey:key];
}


/**
 从缓存池中获取一个对象
 
 @param key key
 @return 获取的对象实例
 */
+ (id)cacheValueForKey:(NSString *)key {
    return [_cachePool objectForKey:key];
}


/**
 清除所有缓存对象
 */
+ (void)removeAllCacheObject {
    [_cachePool removeAllObjects];
}

// MARK: - 格式化日期

+ (NSDateFormatter *)createDateFormatterWithKey:(NSString *)formatterKey {
    NSDateFormatter *formatter = [NSDateFormatter new];
    if ([formatterKey isEqualToString:kYearToSecondFormatterKey]) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else if ([formatterKey isEqualToString:kYearToDayFormatterKey]) {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    else if ([formatterKey isEqualToString:kMonthToMinuteFormatterKey]) {
        [formatter setDateFormat:@"MM-dd HH:mm"];
    }
    else {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    return formatter;
}


// MARK: - 格式化小数位数
+ (NSNumberFormatter * )createNumberFormatterWithKey:(NSString *)formatterKey {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    if ([formatterKey isEqualToString:kUpNumberFormatterKey]) {
        [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    }
    else if ([formatterKey isEqualToString:kDownNumberFormatterKey]) {
        [numberFormatter setRoundingMode:NSNumberFormatterRoundDown];
    }
    else if ([formatterKey isEqualToString:kCurrencyNumberFormatterKey]) {
        numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    //  设置地区为中国
    
    NSLocale *CNLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    [numberFormatter setLocale:CNLocale];
    return numberFormatter;
}


@end
