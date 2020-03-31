//
//  ZJWidgetPoolHeader.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// MARK: - Formatter 格式化样式----Begin

// MARK: - 格式化日期
//时间戳--> 年月日时分秒 Key
static NSString * const kYearToSecondFormatterKey = @"WexYearToSecondFormatterKey";

//时间戳--> 年月日
static NSString * const kYearToDayFormatterKey    = @"WexYearToDayFormatterKey";

//时间戳--> 月-日 小时:分
static NSString * const kMonthToMinuteFormatterKey  = @"WexMonthToMinuteFormatterKey";



// MARK: - 数字金融
//只进位不舍位
static NSString * const kUpNumberFormatterKey       = @"WexNumberFormatterKey";
//只舍位不进位
static NSString * const kDownNumberFormatterKey     = @"WexNumberDownFormatterKey";
//四舍五入形式
static NSString * const kNormalNumberFormatterKey   = @"WexNumberNormalFormatterKey";
//数字货币
static NSString * const kCurrencyNumberFormatterKey  = @"WexCurrencyNumberFormatterKey";


// MARK: - Formatter 格式化样式----End







