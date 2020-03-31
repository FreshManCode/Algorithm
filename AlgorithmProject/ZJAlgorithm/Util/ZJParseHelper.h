//
//  ZJParseHelper.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJParseHelper : NSObject


/**
 给字典按照 key=value&key=value 形式排序
 @param dic 字典
 @return 排序后的string
 */
+ (NSString *)formatDictionaryWithSort:(NSDictionary *)dic;


/**
 是否是有效的Dic

 @param dic dic
 @return YES/NO
 */
+ (BOOL)isValidDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
