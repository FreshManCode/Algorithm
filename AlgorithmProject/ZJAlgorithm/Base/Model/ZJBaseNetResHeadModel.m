//
//  ZJBaseNetResHeadModel.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseNetResHeadModel.h"

@implementation ZJBaseNetResHeadModel
/**
 黑名单
 @return 解析时忽略此集合中的Key
 */
+ (NSArray<NSString *> *)modelPropertyBlacklist {
    return @[@"success",];
}

- (void)setCode:(NSString *)code {
    _code = code;
    _success = [code isEqualToString:@"200"] ? true : false;
}




@end
