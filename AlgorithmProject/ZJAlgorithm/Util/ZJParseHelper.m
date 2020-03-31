//
//  ZJParseHelper.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJParseHelper.h"

@implementation ZJParseHelper

+ (NSString *)formatDictionaryWithSort:(NSDictionary *)dic {
    NSString * result = @"";
    // Keys排序
    NSArray* keys = [dic allKeys];
    NSArray* sortedKeysArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
                                {
                                    return [obj1 compare:obj2 options:NSNumericSearch];
                                }];
    
    // 连接
    NSMutableString* paramString = [NSMutableString stringWithString:@""];
    for (int index = 0; index < sortedKeysArray.count; ++index) {
        NSString* key = sortedKeysArray[index];
        if (sortedKeysArray.count == 1) {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@", key, [dic objectForKey:key]]];
        }
        else if (index == sortedKeysArray.count - 1) {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@", key, [dic objectForKey:key]]];
        }
        else {
            [paramString appendString:[NSString stringWithFormat:@"%@=%@&", key, [dic objectForKey:key]]];
        }
    }
    result = paramString.copy;
    return result;
}


+ (BOOL)isValidDictionary:(NSDictionary *)dic {
    if ([dic isKindOfClass:[NSDictionary class]] &&dic.allKeys.count > 0 ) {
        return true;
    }
    return false;
}


@end
