//
//  ZJRequestCache.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJRequestCache.h"
#import <AFHTTPSessionManager.h>

@implementation ZJRequestCache

/**
 归档response 到本地
 
 @param data 数据
 @param key key
 @return 是否成功
 */
- (BOOL)storeData:(NSDictionary *)data
              key:(NSString *)key {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSMutableData *mutableData = [[NSMutableData alloc]init];
        NSKeyedArchiver *archiver  = [[NSKeyedArchiver alloc]initForWritingWithMutableData:mutableData];
        [archiver encodeObject:data forKey:@"cacheData"];
        [archiver finishEncoding];
        [self storeFile:mutableData fileName:key];
        return true;
    }
    return false;    
}

/**
 根据key 去获取数据
 
 @param key key
 @return response
 */
- (NSDictionary *)dataForKey:(NSString *)key {
    NSString *savePath = [[self cacheDirectoryPath] stringByAppendingPathComponent:key];
    NSData *encodeData = [[NSData alloc]initWithContentsOfFile:savePath];
    if (encodeData) {
        NSKeyedUnarchiver *unarchive = [[NSKeyedUnarchiver alloc]initForReadingWithData:encodeData];
        NSDictionary *decodeDic      = [unarchive decodeObjectForKey:@"cacheData"];
        [unarchive finishDecoding];
        return decodeDic;
    }
    return nil;
}

- (NSString *)cacheDirectoryPath {
    NSString *mainCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *tempPath      = [mainCachePath stringByAppendingPathComponent:@"RequestCache"];
    return tempPath;
}

- (void)storeFile:(NSData *)data fileName:(NSString *)name {
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSString *savePath        = [[self cacheDirectoryPath] stringByAppendingPathComponent:name];
    if (![fileManger fileExistsAtPath:savePath]) {
        [fileManger createDirectoryAtPath:[savePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [data writeToFile:savePath atomically:YES];
}


/**
 往header里面添加Cookie
 
 @param manager 对应的实例变量
 */
- (void)addCookieToHeader:(AFHTTPSessionManager *)manager {
    NSString *token = [self tokenWithKey:@""];
    if (token) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@""];
    }
}
/**
 保存response的cookie
 
 @param headers headers
 */
- (void)storeCookieWithHeader:(NSDictionary *)headers {
    [headers enumerateKeysAndObjectsUsingBlock:^(id key, id  obj, BOOL * stop) {
        if ([key isEqualToString:@""]) {
            [self setToken:obj key:key];
        }
    }];
}

- (void)setToken:(NSString *)token key:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:key];
    [userDefaults synchronize];
}

- (NSString *)tokenWithKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* token = [userDefaults objectForKey:key];
    return token;
}

@end
