//
//  UIImage+ZJTools.h
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/8.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZJTools)


/**
 添加文字水印

 @param text text
 */
- (UIImage *)addMaskText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
