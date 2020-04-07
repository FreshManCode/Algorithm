//
//  ZJSectionModel.h
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSectionModel : NSObject

@property (nonatomic, copy) NSString *sectionName;
@property (nonatomic, copy) NSString *sectionClassName;

@end


@interface ZJRowImageModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *imageURL;
/**函数名*/
@property (nonatomic, copy) NSString *functionName;

- (void)setText:(NSString * _Nullable)text
       imageURL:(NSString * _Nullable)imageURL;

- (void)setText:(NSString * _Nullable)text
       imageURL:(NSString * _Nullable)imageURL
   functionName:(NSString * _Nullable )functionName;


@end

NS_ASSUME_NONNULL_END
