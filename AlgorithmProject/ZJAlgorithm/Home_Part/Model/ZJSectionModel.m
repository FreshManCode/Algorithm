//
//  ZJSectionModel.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/31.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJSectionModel.h"

@implementation ZJSectionModel

@end

@implementation ZJRowImageModel
- (void)setText:(NSString *)text
       imageURL:(NSString *)imageURL {
    [self setText:text imageURL:imageURL functionName:nil];
}

- (void)setText:(NSString *)text
       imageURL:(NSString *)imageURL
   functionName:(NSString *)functionName {
    self.text     = text;
    self.imageURL = imageURL;
    self.functionName = functionName;
}


@end
