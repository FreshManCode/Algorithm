//
//  UIImageView+ZJCacheImageView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "UIImageView+ZJCacheImageView.h"
#import <YYKit.h>
#import <UIImageView+WebCache.h>
#import "NSString+ZJTools.h"

@implementation UIImageView (ZJCacheImageView)

- (void)zj_imageWithURL:(NSString *)imageURL
            placeHolder:(UIImage *)placeHoder {
    
    if (![imageURL isValidString]) {
        [self setImage:placeHoder];
        return;
    }
    
//    [self sd_setImageWithURL:[NSURL URLWithString:imageURL]
//            placeholderImage:placeHoder
//                     options:SDWebImageAllowInvalidSSLCertificates];
//
    [self setImageWithURL:[NSURL URLWithString:imageURL]
              placeholder:placeHoder
                  options:YYWebImageOptionAllowInvalidSSLCertificates
               completion:^(UIImage * image, NSURL * url, YYWebImageFromType from, YYWebImageStage stage, NSError *  error) {
               }];

}

@end
