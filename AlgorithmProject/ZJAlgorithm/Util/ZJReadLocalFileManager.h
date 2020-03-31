//
//  ZJReadLocalFileManager.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/4.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 该回调在主线程中进行的
 
 @param data 数据 (dic,array)
 @param error 错误
 */
typedef void (^ZJReadDataResult)(id __nullable data,NSError * _Nullable error);

@interface ZJReadLocalFileManager : NSObject


- (void)readFileName:(NSString *)fileName
              format:(NSString *)format
              result:(ZJReadDataResult)result;

@end

NS_ASSUME_NONNULL_END
