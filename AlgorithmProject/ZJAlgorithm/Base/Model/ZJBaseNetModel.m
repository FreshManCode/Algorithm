//
//  ZJBaseNetModel.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseNetModel.h"

@implementation ZJBaseNetModel

@end

@implementation ZJBaseUpImageNetModel

+ (NSArray<NSString *> *)modelPropertyBlacklist {
    return @[@"image"];
}
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"contentA":@"content"};
}

- (void)setImage:(UIImage *)image {
    _image = image;
//  2020.3.31 记录Imagedata->base64 后台无法识别的问题,使用默认的Options不行
    NSData *imageData = UIImageJPEGRepresentation(image, 0.85f);
    NSString *encodeImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    [self setContent:encodeImageStr];
}

+ (instancetype)initWithImage:(UIImage *)image
                      message:( NSString * _Nullable )meesage {
    ZJBaseUpImageNetModel *requestModel = [self new];
    [requestModel setAccess_token:@"f97b94d613818ad61e44ef0820471892"];
    [requestModel setImage:image];
    [requestModel setMessage:meesage];
    return requestModel;
}
- (void)setAccess_token:(NSString * _Nonnull)access_token {
    _access_token =access_token;
}


@end
