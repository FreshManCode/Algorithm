//
//  NSString+ZJTools.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "NSString+ZJTools.h"
#import "ZJWidgetPool.h"


@implementation NSString (ZJTools)

+ (BOOL)isNotEmpty:(NSString *)string
{
    return ![self isEmpty:string];
}

+ (BOOL)isEmpty:(NSString *)string
{
    
    if (![[self class] isSubclassOfClass:[NSString class]]) {
        return YES;
    }
    return ([string isKindOfClass:[NSNull class]] || !string || ![string trim].length);
}

- (NSString *)trim
{
    if (![[self class] isSubclassOfClass:[NSString class]]) {
        return @"";
    }
    
    if (!self.length)
        return @"";
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// MARK: - 时间戳--->时间
/**
 时间戳--> 年月日时分秒
 
 @return **年*月*日*时*分*秒
 */
- (NSString *)yearToSecondTime {
    if (![self isValidString]) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self standardSecondTimeSamp]];
    return [[ZJWidgetPool dateFormatterForKey:kYearToSecondFormatterKey]
            stringFromDate: date];
    
}

/**
 时间戳--> 年月日
 
 @return **年*月*日
 */
- (NSString *)yearToDayTime {
    if (![self isValidString]) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self standardSecondTimeSamp]];
    return [[ZJWidgetPool dateFormatterForKey:kYearToDayFormatterKey]
            stringFromDate: date];
}

/**
 时间戳 --->月-日 时:分
 
 @return  月-日 时:分
 */
- (NSString *)monthToMinuteTime {
    if (![self isValidString]) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self standardSecondTimeSamp]];
    return [[ZJWidgetPool dateFormatterForKey:kMonthToMinuteFormatterKey]
            stringFromDate: date];
    
}


/**
 统一为秒级时间戳 (防止微秒级和秒级错乱)
 
 @return 秒级时间戳
 */
- (CGFloat)standardSecondTimeSamp {
    NSTimeInterval interval  = [self doubleValue];
    if (self.length > 10) {
        interval = interval / 1000.f;
    }
    return interval;
}

/**
 截取银行卡后四位
 
 @return 截取后的银行卡
 */
- (NSString *)cardLastNumber {
    if ([self length] > 4) {
        return [self substringFromIndex:self.length - 4];
    }
    return @"";
}

/**
 把字符串 "Y/y,n/N" 转成对应的bool 类型
 
 @return YES/NO
 */
- (BOOL)isTrueValue {
    if ([[self uppercaseString] isEqualToString:@"Y"]) {
        return true;
    }
    return false;
}

/**
 把nil,nsnull,以及不规范的string类型转为-->@""
 
 @return 规范后的string
 */
- (NSString *)formatString {
    if ([self isValidString]) {
        return self;
    }
    return @"";
}


/**
 是否是有效的字符串

 @return YES/NO
 */
- (BOOL)isValidString {
    if ([self isKindOfClass:[NSString class]] && self.length > 0) {
        return true;
    }
    return false;
}

/**
 json(Stirng)-->json(dict)
 
 
 @return dic
 */
- (NSDictionary *)jsonDictionary {
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



@end
