//
//  ZJDiscoverlistItemModel.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/29.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface ZJDiscoverlistItemModel : ZJBaseModel
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *image_ratio;
@property (nonatomic, assign) CGFloat kImageHeight;

@end

NS_ASSUME_NONNULL_END
