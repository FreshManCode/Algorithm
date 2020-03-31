//
//  NSObject+ZJEncoder.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/27.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "NSObject+ZJEncoder.h"
#import "NSObject+YWMethodAddition.h"

@implementation NSObject (ZJEncoder)

/**
 编码
 @param aCoder 编码器
 */
- (void)zj_encodeWithCoder:(NSCoder *)aCoder {
    NSArray <NSString *> *propertyNames = [self allPropertys];
    [propertyNames enumerateObjectsUsingBlock:^(NSString *  obj, NSUInteger idx, BOOL *  stop) {
        id value = [self valueForKey:obj];
        if (value  && ![value isKindOfClass:[NSNull class]]) {
            [aCoder encodeObject:value forKey:obj];
        }
    }];
}


/**
 解码
 @param aDecoder 解码器
 */
- (void)zj_decoderWithDecoder:(NSCoder *)aDecoder {
    NSArray <NSString *> *propertyNames = [self allPropertys];
    [propertyNames enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * stop) {
        id value = [aDecoder decodeObjectForKey:obj];
        if (value && ![value isKindOfClass:[NSNull class]]) {
            [self setValue:value  forKey:obj];
        }
    }];
}

@end
