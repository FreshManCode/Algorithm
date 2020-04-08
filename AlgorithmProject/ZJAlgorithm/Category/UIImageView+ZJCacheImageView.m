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
#import <SDWebImage.h>

@implementation UIImageView (ZJCacheImageView)

- (void)zj_imageWithURL:(NSString *)imageURL
            placeHolder:(UIImage *)placeHoder {
    [self zj_imageWithURL:imageURL placeHolder:placeHoder completion:nil];
    
   

}

- (void)zj_imageWithURL:(NSString *)imageURL
            placeHolder:(UIImage *)placeHoder
             completion:(ZJLoadURLImage )completion {
    if (![imageURL isValidString]) {
        [self setImage:placeHoder];
        return;
    }
    
    
    if ([imageURL containsString:@"gitee"]) {
        //SDWebImage 一个难以想象的BUG
        NSString *userAgent = @"";
        userAgent = [NSString stringWithFormat:@"%@/%@ (%@; iOS %@; Scale/%0.2f)", [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
        
        if (userAgent) {
            if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
                NSMutableString *mutableUserAgent = [userAgent mutableCopy];
                if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                    userAgent = mutableUserAgent;
                }
            }
            [[SDWebImageDownloader sharedDownloader] setValue:userAgent forHTTPHeaderField:@"User-Agent"];
        }
        [SDWebImageDownloader.sharedDownloader setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
                                     forHTTPHeaderField:@"Accept"];

        [self sd_setImageWithURL:[NSURL URLWithString:imageURL]
                placeholderImage:placeHoder
                         options:SDWebImageAllowInvalidSSLCertificates
                        progress:nil
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            !completion ? : completion (image);
        }];
        
    }
    else {
        [self setImageWithURL:[NSURL URLWithString:imageURL]
                  placeholder:placeHoder
                      options:YYWebImageOptionAllowInvalidSSLCertificates
                   completion:^(UIImage * image, NSURL * url, YYWebImageFromType from, YYWebImageStage stage, NSError *  error) {
                       !completion ? : completion (image);
                   }];
    }

}


/**
 加载完成之后,需要手动设置图片
 
 @param imageURL 图片URL
 @param placeHoder 占位图片
 @param completion 回调
 */
- (void)zj_maunalLoadImageWithURL:(NSString *)imageURL
                      placeHolder:(UIImage *)placeHoder
                       completion:(ZJLoadURLImage __nullable )completion {
    [self setImageWithURL:[NSURL URLWithString:imageURL]
              placeholder:placeHoder
                  options:YYWebImageOptionAllowInvalidSSLCertificates|YYWebImageOptionAvoidSetImage
               completion:^(UIImage * image, NSURL * url, YYWebImageFromType from, YYWebImageStage stage, NSError *  error) {
                   !completion ? : completion (image);
               }];
}

@end
