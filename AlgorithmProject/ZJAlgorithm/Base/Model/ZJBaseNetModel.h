//
//  ZJBaseNetModel.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseNetModel : ZJBaseModel

@end

@interface ZJBaseUpImageNetModel : ZJBaseNetModel

@property (nonatomic, strong) UIImage *image;
/**上传时的描述信息*/
@property (nonatomic, copy) NSString *message;
/**gitee.com 上的对应仓库的私钥*/
@property (nonatomic, copy,readonly) NSString *access_token;
/**
 image base64之后的内容
 */
@property (nonatomic, copy) NSString *content;

+ (instancetype)initWithImage:(UIImage *)image
                      message:( NSString * _Nullable )meesage;


@end

NS_ASSUME_NONNULL_END
