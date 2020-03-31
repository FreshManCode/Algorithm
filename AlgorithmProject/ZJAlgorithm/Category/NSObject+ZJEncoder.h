//
//  NSObject+ZJEncoder.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/27.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  快速编码,解码类 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZJEncoder) 


/**
 编码
 @param aCoder 编码器
 */
- (void)zj_encodeWithCoder:(NSCoder *)aCoder;

/**
 解码
 @param aDecoder 解码器
 */
- (void)zj_decoderWithDecoder:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
