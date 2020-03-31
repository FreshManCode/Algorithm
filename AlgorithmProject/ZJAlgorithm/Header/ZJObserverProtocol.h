//
//  ZJObserverProtocol.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZJBaseModel;

@protocol ZJObserverProtocol <NSObject>

@optional;
/**更新相应的状态*/
- (void)updateState;
/**
 更新相应的状态

 @param model 传递相应的数据
 */
- (void)updateState:(ZJBaseModel *)model;

@end

NS_ASSUME_NONNULL_END
