//
//  ZJBaseNetResHeadModel.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseNetResHeadModel : ZJBaseModel <YYModel>

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *msg;
/**请求是否成功*/
@property (nonatomic, assign,readonly,getter=isSuccess) BOOL success;



@end

NS_ASSUME_NONNULL_END
