//
//  ZJBaseCommand.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJCommonMacros.h"
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseCommand : NSObject

/**
 返回按钮事件 (默认上一级页面)

 @param fromVC 从哪个ViewController 发起
 */
- (void)zj_backButtonEvent:(UIViewController *)fromVC;

/**
 push/Pop到指定Controller (需要对应的子类去实现)

 @param fromVC 从哪个界面发起
 */
- (void)zj_pushToSepecificViewController:(UIViewController *)fromVC;

@end

NS_ASSUME_NONNULL_END
