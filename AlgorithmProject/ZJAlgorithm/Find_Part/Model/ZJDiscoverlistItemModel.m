//
//  ZJDiscoverlistItemModel.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJDiscoverlistItemModel.h"

#define kMaxWidth  floorf((ZJScreenWidth - 30 )/2.0)



@implementation ZJDiscoverlistItemModel

- (void)setImage_ratio:(NSString *)image_ratio {
    _image_ratio = image_ratio;
    CGFloat ratio = [image_ratio floatValue];
    if (ratio != 0) {
        _kImageHeight = kMaxWidth / ratio;
    } else {
        _kImageHeight = kMaxWidth;
    }
}

@end
