//
//  ZJUpLoadImageModel.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJUpLoadImageModel.h"

@implementation ZJUpLoadImageModel

@end


@implementation ZJUpLoadImageResModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"content":[ZJUpLoadImageContentModel class]};
}


@end

@implementation ZJUpLoadImageContentModel

@end


