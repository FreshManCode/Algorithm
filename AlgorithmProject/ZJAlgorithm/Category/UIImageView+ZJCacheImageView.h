//
//  UIImageView+ZJCacheImageView.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZJLoadURLImage)(UIImage * __nullable image);

@interface UIImageView (ZJCacheImageView)

- (void)zj_imageWithURL:(NSString *)imageURL
            placeHolder:(UIImage *)placeHoder;


- (void)zj_imageWithURL:(NSString *)imageURL
            placeHolder:(UIImage *)placeHoder
             completion:(ZJLoadURLImage __nullable )completion;


@end

NS_ASSUME_NONNULL_END
