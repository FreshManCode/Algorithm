//
//  ZJBaseNetAdapterProtocol.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@class ZJBaseNetAdapter;
@class ZJBaseNetResHeadModel;
@class ZJBaseNetModel;

@protocol ZJBaseNetAdapterProtocol <NSObject>


@optional;


/**
 网络请求开始前

 @param adapter 对应的适配器
 @param param 参数Model
 */
- (void)ZJBaseNetAdapterDelegate:(ZJBaseNetAdapter*)adapter
                       beforeRun:(ZJBaseNetModel*)param;


/**
 网络请求回调
 
 @param adapter 相应的适配器
 @param headModel 响应头 (head)
 @param response 响应体 (body)
 */
- (void)ZJBaseNetAdapterDelegate:(ZJBaseNetAdapter*)adapter
                            head:(ZJBaseNetResHeadModel *)headModel
                        response:(nullable ZJBaseNetModel*)response;


/**
 请求图片回调
 
 @param adapter 相应的适配器
 @param headModel 响应头 (head)
 @param responseImage 返回的图片
 */
- (void)ZJBaseNetAdapterDelegate:(ZJBaseNetAdapter*)adapter
                            head:(ZJBaseNetResHeadModel *)headModel
                   responseImage:(UIImage *)responseImage;


@end

NS_ASSUME_NONNULL_END
