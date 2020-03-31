//
//  ZJUploadImageManager.h
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJUploadImageManager : NSObject

+ (instancetype)manager;

- (void)pushToSelectImageViewController:(ZJBaseViewController *)fromVC;




@end

NS_ASSUME_NONNULL_END
