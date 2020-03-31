//
//  ZJBaseNetAdapter.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  网络请求基类

#import <Foundation/Foundation.h>
#import "ZJBaseNetAdapterProtocol.h"
#import "ZJBaseNetModel.h"
#import "ZJRequestURLHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZJBaseNetRequestType) {
    ZJBaseNetRequestTypePOST, //POST 请求
    ZJBaseNetRequestTypeGET,  //Get请求
};

typedef NS_ENUM(NSInteger,ZJNetAdapterStatus) {
    ZJNetAdapterStatusRun, //接口调用中
    ZJNetAdapterStatusIdle, //接口空闲中
};


@interface ZJBaseNetAdapter : NSObject <ZJBaseNetAdapterProtocol>

{
    struct {
        unsigned int NetAdapterBeforeRun     : 1;
        unsigned int NetAdapterResponse      : 1;
        unsigned int NetAdapterResponseImage : 1;
    }_DelegateFlags;
}

/**回调代理对象*/
@property (nonatomic, weak) id <ZJBaseNetAdapterProtocol> delegate;
/**请求参数Model,不带参数就是nil*/
@property (nonatomic, strong) ZJBaseNetModel * paramModel;
/**接口调用状态 (空闲,调用中)*/
@property (nonatomic, assign,readonly) ZJNetAdapterStatus status;
/**是否缓存对应的数据到Temporary对应的目录下 (默认不缓存)*/
@property (nonatomic, assign,getter = isCacheData) BOOL cacheData;
/**是否处理默认的请求提示动画(默认为Yes),由父类统一处理一个提交动画*/
@property (nonatomic, assign) BOOL defaultRequestUIHandle;

/**完整的URL 路径*/
@property (nonatomic, copy,readonly) NSString *fullRequestUrl;

/**最外层解析的key,默认为data*/
@property (nonatomic, copy) NSString *parseKey;

/**动态的文件路径在URL中拼接,默认为nil
 (比如/Image/haha.png)
 */
@property (nonatomic, copy) NSString *URLFilePath;



// 接口地址，子类必须覆写
- (NSString*)getRequestUrl;

// 得到基本的URL
- (NSString*)getBaseRequestUrl;


/**
 自定义完整的请求URL 实现该方法,getRequestUrl方法可以忽略

 @return 请求的URL,默认为nil;
 */
- (NSString *)absoluteRequestURL;

#pragma mark - 子类非必须覆写
/**
 获取基本请求类型

 @return 默认 ZJBaseUrlTypeNormal
 */
- (ZJBaseUrlType)getBasetUrlType;
/**
 获取网络请求类型 post or get 默认为Post

 @return 网络请求类型枚举
 */
- (ZJBaseNetRequestType)getNetAdapterRequestType;

// 参数是否需要加签
- (BOOL)isSignatureParamters;

/**
 是否需要Token
 @return YES/NO
 */
- (BOOL)isNeedToken;

/**
 调用接口
 
 @param paramModal 参数Model
 */
- (void)run:(nullable ZJBaseNetModel*)paramModal;



/**
 上传图片接口

 @param paramModal imageModel
 */
- (void)runImage:(nullable ZJBaseUpImageNetModel *)paramModal;

/**
 获取解析对应的Model
 
 @return 序列化之后的Model
 */
- (Class)getResponseClass;

/**
 基本公共参数
 
 @return 公共参数
 */
- (NSDictionary *)basicParams;



/**
 请求超时时间
 @return 时间
 */
- (NSTimeInterval)getTimeoutInterval;



@end

NS_ASSUME_NONNULL_END
