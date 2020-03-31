//
//  UIColor+ZJExpand.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/4.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ZJColorWithString(string) [UIColor colorFromHexCode:string]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZJExpand)

+ (UIColor *) colorFromHexCode:(NSString *)hexString;

+ (UIColor *) colorFromHexCode:(NSString *)hexString alpha:(CGFloat)aAlpha;



@end

NS_ASSUME_NONNULL_END
