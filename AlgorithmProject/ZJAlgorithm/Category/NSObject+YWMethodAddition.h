//
//  NSObject+YWMethodAddition.h
//  ImitateBaiduCourse
//
//  Created by stone on 2018/2/27.
//  Copyright © 2018年 能伍网络. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (YWMethodAddition)

+ (NSMutableAttributedString *)getAttributeStringWithContent:(NSString *)content
                                                 lineSpacing:(CGFloat)space
                                                    wordFont:(UIFont *)font;

- (CGSize)attributionHeightWithString:(NSString *)string
                            lineSpace:(CGFloat)lineSpace
                                 font:(UIFont *)font
                                width:(CGFloat)width;

/**
 获取所有的属性
 
 @return 属性集合
 */
- (NSArray *)allPropertys;



/**
 获取所有的属性 过滤不想进行操作的属性
 
 @param ignoredArrays 需要过滤属性的集合
 @return 除了需要过滤属性之外的属性集合
 */
- (NSArray *)allPropertysWithIgnoredSet:(NSArray <NSString *> *)ignoredArrays;


/**
 获取当前时间戳 (s级要是转为ms级需要*1000)
 
 @return 时间戳
 */
- (NSTimeInterval)currentTimestamp;

@end
