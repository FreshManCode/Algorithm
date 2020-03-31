//
//  ZJUpLoadImageModel.h
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseNetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJUpLoadImageModel : ZJBaseNetModel

@end

@interface ZJUpLoadImageContentModel : ZJBaseNetModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *sha;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *html_url;
/**文件的下载链接*/
@property (nonatomic, copy) NSString *download_url;



@end

@interface ZJUpLoadImageResModel : ZJBaseNetModel

@property (nonatomic, strong) ZJUpLoadImageContentModel *content;

@end


NS_ASSUME_NONNULL_END
