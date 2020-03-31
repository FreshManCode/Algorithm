//
//  NSString+ZJTools.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJTools)

/**
 时间戳--> 年月日时分秒
 
 @return **年*月*日*时*分*秒
 */
- (NSString *)yearToSecondTime;

/**
 时间戳--> 年月日
 
 @return **年*月*日
 */
- (NSString *)yearToDayTime;

/**
 时间戳 --->月-日 时:分
 
 @return  月-日 时:分
 */
- (NSString *)monthToMinuteTime;

/**
 截取银行卡后四位
 
 @return 截取后的银行卡
 */
- (NSString *)cardLastNumber;

/**
 把nil,nsnull,以及不规范的string类型转为-->@""
 
 @return 规范后的string
 */
- (NSString *)formatString;

/**
 是否是有效的字符串
 
 @return YES/NO
 */
- (BOOL)isValidString;



/**
 json(Stirng)-->json(dict)
 

 @return dic
 */
- (NSDictionary *)jsonDictionary;

@end

NS_ASSUME_NONNULL_END
