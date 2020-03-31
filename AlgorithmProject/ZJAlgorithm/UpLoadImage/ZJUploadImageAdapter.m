//
//  ZJUploadImageAdapter.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJUploadImageAdapter.h"

@implementation ZJUploadImageAdapter

- (NSString *)absoluteRequestURL {
    return @"https://gitee.com/api/v5/repos/yongEagle/GiteeImageURL/contents/";
}

- (Class)getResponseClass {
    return [ZJUpLoadImageResModel class];
}

- (NSString *)parseKey {
    return @"Content";
}

@end
