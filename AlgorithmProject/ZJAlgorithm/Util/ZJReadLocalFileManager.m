//
//  ZJReadLocalFileManager.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/4.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  读取本地数据

#import "ZJReadLocalFileManager.h"

@interface ZJReadLocalFileManager ()

@property (nonatomic,copy) ZJReadDataResult DataResult;

@end


@implementation ZJReadLocalFileManager

- (void)readFileName:(NSString *)fileName
              format:(NSString *)format
              result:(ZJReadDataResult)result {
    ZJDispatch_async(^{
        NSError *error = nil;
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:fileName ofType:format];
        NSData *jsonData = [NSData dataWithContentsOfFile:bundlePath];
        if (jsonData) {
            id json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            ZJDispatch_asyncMain(^{
                !result ? : result (json,error) ;
            });
        }
        else {
            error = [NSError errorWithDomain:@"ZJReadLocalFileManager" code:40000 userInfo:nil];
            !result ? : result (nil,error) ;
        }
        
        ZJNSLOG(@"fileName:\n%@---error:%@",fileName,error);
    });
}


@end
