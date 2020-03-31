//
//  ZJBaseNetAdapter.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseNetAdapter.h"
#import <AFNetworking.h>
#import "ZJRequestCache.h"
#import "ZJParseHelper.h"
#import "ZJBaseNetAdapter.h"
#import "ZJBaseNetAapterExceptionHelper.h"
#import "ZJBaseNetResHeadModel.h"
#import "ZJBaseNetModel.h"
#import "NSString+ZJTools.h"


@interface ZJBaseNetAdapter ()
@property (nonatomic, strong) AFHTTPSessionManager *pManager;
@property (nonatomic, strong) AFHTTPSessionManager *uploadManager;
/**缓存相关Class (header,token,response)*/
@property (nonatomic, strong) ZJRequestCache *requestCache;

@end

@implementation ZJBaseNetAdapter


- (instancetype)init {
    if (self = [super init]) {
        //默认统一处理提交时的刷新动画
        _defaultRequestUIHandle = true;
        //默认接口状态为闲置
        _status = ZJNetAdapterStatusIdle;
    }
    return self;
}

- (void)run:(ZJBaseNetModel *)paramModal {
    _paramModel = paramModal;
    if (_DelegateFlags.NetAdapterBeforeRun) {
        [_delegate ZJBaseNetAdapterDelegate:self beforeRun:_paramModel];
    }
    _status = ZJNetAdapterStatusRun;
    [[ZJBaseNetAapterExceptionHelper helper] pushAdapter:self];
    NSDictionary *localData = [self.requestCache dataForKey:[self key]];
    if (localData) {
        [self requestSuccessFinish:localData isCache:true];
    }
    __weak typeof(self) weakSelf     = self;
    if ([self isNeedToken]) {
        [self.requestCache addCookieToHeader:self.pManager];
    }
    if ([self getNetAdapterRequestType] == ZJBaseNetRequestTypePOST) {
        [self.pManager POST:[self fullRequestUrl]
                 parameters:[self parameters] progress:^(NSProgress * _Nonnull uploadProgress) {
                     
                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     [weakSelf handleWithResponse:responseObject task:task];
                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     [weakSelf requestErrorFinish:error];
                 }];
    }
    else {
        [self.pManager GET:[self fullRequestUrl]
                parameters:[self parameters]
                  progress:^(NSProgress * _Nonnull downloadProgress) {
                      
                  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      [weakSelf handleWithResponse:responseObject task:task];
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      [weakSelf requestErrorFinish:error];
                  }];
    }
}
/**
 上传图片接口
 
 @param paramModal imageModel
 */
- (void)runImage:(ZJBaseUpImageNetModel *)paramModal {
    if (paramModal.content.length < 1) {
        NSError *error = [NSError errorWithDomain:@"com.error.paramter" code:10000 userInfo:@{NSLocalizedFailureReasonErrorKey:@"参数错误"}];
        [self requestErrorFinish:error];
        return;
    }
   
    _paramModel = paramModal;
    if (_DelegateFlags.NetAdapterBeforeRun) {
        [_delegate ZJBaseNetAdapterDelegate:self beforeRun:_paramModel];
    }
    NSDictionary *jsonDic = [[_paramModel modelToJSONString] jsonDictionary];
    _status = ZJNetAdapterStatusRun;
    [[ZJBaseNetAapterExceptionHelper helper] pushAdapter:self];
    __weak typeof(self) weakSelf     = self;
    if ([self isNeedToken]) {
        [self.requestCache addCookieToHeader:self.pManager];
    }
    NSString *requestURL = [self fullRequestUrl];
    if ([self absoluteRequestURL].length > 0) {
        requestURL = [self absoluteRequestURL];
    }
    if (self.URLFilePath.length > 0) {
        requestURL = [NSString stringWithFormat:@"%@%@",requestURL,self.URLFilePath];
    }
    [self.pManager POST:requestURL
             parameters:jsonDic
               progress:^(NSProgress * _Nonnull uploadProgress) {
             } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [weakSelf handleWithResponse:responseObject task:task];
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [weakSelf requestErrorFinish:error];
             }];
    
    
    
}

// MARK: - 处理接口响应数据
- (void)handleWithResponse:(id)response task:(NSURLSessionDataTask *)task {
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)task.response;
    [self.requestCache storeCookieWithHeader:res.allHeaderFields];
    [self requestSuccessFinish:response isCache:false];
    ZJNSLOG(@"\nURL: %@\nContent: %@", [self getRequestUrl], [response description]);
}

- (void)requestSuccessFinish:(id)responseObject
                     isCache:(BOOL)isCache {
    if (!isCache) {_status = ZJNetAdapterStatusIdle;}
    //  该adapter因为SESSION超时已被清空
    //  1.防止重入 2.截断此前已提交的所有接口
    if ([[ZJBaseNetAapterExceptionHelper helper] adapterIsExited:self] == false) {
        return;
    }
    NSDictionary *headDic = responseObject[@"head"];
    
    ZJBaseNetResHeadModel *headModel = [ZJBaseNetResHeadModel modelWithDictionary:headDic];
    //    if ([headModel.code isEqualToString:WXTokenInvalidCode]) {
    //        [WXProgressHUD showTipsTextInWindow:@"Token已经失效,请在首页先获取Token再进行操作"];
    //    }
    //
    ZJBaseNetModel *resModel = nil;
    NSDictionary   *data  = nil;
    NSDictionary *bodyDic = nil;
    //  针对不同的BaseURL中返回的body结构可能不太一样做处理,如果一样可以忽略.
    if (self.parseKey.length > 0) {
        bodyDic = [responseObject objectForKey:self.parseKey];
    }
    else {
        bodyDic = [responseObject objectForKey:@"data"];
    }
    if ([self getResponseClass]) {
        if (data == nil || [data class] == [NSNull class]) {
            resModel =  [[self getResponseClass]modelWithDictionary:bodyDic];
        }
        else {
            if ([data isKindOfClass:[NSDictionary class]]) {
                resModel = [[self getResponseClass]modelWithDictionary:data];
            }
            else {
                resModel = [[self getResponseClass]modelWithDictionary:bodyDic];
            }
        }
    }
    else {
        //没有设置ResponseClass 时,且错误的时候,返回错误信息 errMsg
        if (!headModel.isSuccess) {
            resModel = [ZJBaseNetModel modelWithJSON:bodyDic];
        }
    }
    // 将缓存的adapter释放
    [[ZJBaseNetAapterExceptionHelper helper] popAdapter:self];
    if (_DelegateFlags.NetAdapterResponse) {
        [_delegate ZJBaseNetAdapterDelegate:self head:headModel response:resModel];
    }
    [self cacheResponseObject:responseObject isCache:isCache headModel:headModel resmodel:resModel];
}


// MARK: - 请求失败处理
- (void)requestErrorFinish:(NSError *)error {
    ZJNSLOG(@"\nURL: %@\nError: %@", [self getRequestUrl], error);
    _status = ZJNetAdapterStatusIdle;
    // 该adapter因为SESSION超时已被清空
    // 1. 防止重入
    // 2. 截断此前已提交的所有接口
    if ([[ZJBaseNetAapterExceptionHelper helper]adapterIsExited:self] == NO) {
        return;
    }
    //    可在此配置网络加载指示器
    //    [WeXPorgressHUD hideLoading];
    ZJBaseNetResHeadModel *headModel = [[ZJBaseNetResHeadModel alloc] init];
    headModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];
    BOOL isTimeOut = false;
    //NSURLErrorCannotConnectToHost   Could not connect to the server (连接host失败)
    //NSURLErrorNetworkConnectionLost
    //NSURLErrorNotConnectedToInternet  -1009 网络不可用
    //-1005  NSURLErrorNetworkConnectionLost（连接过程中被中断）
    //  网络连接有问题
    if (error.code == NSURLErrorCannotConnectToHost ||
        error.code == NSURLErrorNotConnectedToInternet||
        error.code == NSURLErrorNetworkConnectionLost ||
        error.code == NSURLErrorDataNotAllowed ||
        error.code == NSURLErrorCallIsActive ||
        error.code == NSURLErrorInternationalRoamingOff ){
        headModel.msg = @"网络连接失败,请检查网络";
        isTimeOut = false;
    }
    else if (error.code == NSURLErrorTimedOut) {
        headModel.msg = @"请求超时，请稍后重试!";
        isTimeOut = true;
    }
    else {
        headModel.msg = @"请求超时，请稍后重试!";
        isTimeOut = true;
    }
    headModel.msg = headModel.msg;
    ZJNSLOG(@"请求失败,error.code is :%ld",(long)error.code);
    //  将缓存的adaper释放
    [[ZJBaseNetAapterExceptionHelper helper] popAdapter:self];
    if (_DelegateFlags.NetAdapterResponse) {
        [_delegate ZJBaseNetAdapterDelegate:self head:headModel response:nil];
    }
    [self postNetErrorNotification:isTimeOut];
}


// MARK: - 发送网络请求错误的通知
- (void)postNetErrorNotification:(BOOL)isTimeTout {
//    NSString *value        = isTimeTout ? WX_ErrorTimeoutValue :  WX_ErrorNoNetworkValue;
//    NSDictionary *valueDic = @{WXNetErrorAdapterKey:self,
//                               WXNetErrorKey:value,
//                               };
//    [[NSNotificationCenter defaultCenter] postNotificationName:WXNetErrorNotiName object:valueDic];
}


// MARK: - 缓存需要保存的数据
- (void)cacheResponseObject:(id)responseObject
                    isCache:(BOOL)isCache
                  headModel:(ZJBaseNetResHeadModel *)headModel
                   resmodel:(ZJBaseNetModel *)resModel {
    if ([headModel isSuccess] && !isCache) {
        [self.requestCache storeData:responseObject key:[self key]];
    }
}


// MARK: - Setter----Getter
- (void)setCacheData:(BOOL)cacheData {
    _cacheData = cacheData;
    [[self requestCache] setOpenCache:cacheData];
}
- (void)setDelegate:(id<ZJBaseNetAdapterProtocol>)delegate {
    _delegate = delegate;
    _DelegateFlags.NetAdapterBeforeRun = [_delegate respondsToSelector:@selector(ZJBaseNetAdapterDelegate:beforeRun:)];
    _DelegateFlags.NetAdapterResponse = [_delegate respondsToSelector:@selector(ZJBaseNetAdapterDelegate:head:response:)];
    _DelegateFlags.NetAdapterResponseImage = [_delegate respondsToSelector:@selector(ZJBaseNetAdapterDelegate:head:responseImage:)];
}

- (NSString *)key {
    NSDictionary *params    = [_paramModel modelToJSONObject];
    NSString *params_string = [ZJParseHelper formatDictionaryWithSort:params];
    NSMutableString *key = [NSMutableString string];
    NSString *requestURL = [self fullRequestUrl];
    [key appendString:requestURL];
    [key appendString:@"?"];
    NSString *requestType= @"POST";
    if ([self getNetAdapterRequestType] == ZJBaseNetRequestTypeGET) {
        requestType = @"GET";
    }
    [key appendString:[NSString stringWithFormat:@"operationType=%@&%@",requestType,params_string]];
    return key.copy;
}

- (NSTimeInterval)getTimeoutInterval {
    return 60.f;
}

// 接口地址，子类必须覆写
- (NSString*)getRequestUrl {
    return @"";
}


/**
 获得完整的URL
 @return URL
 */
- (NSString *)fullRequestUrl {
    NSMutableString *URL = [NSMutableString stringWithString: [self getBaseRequestUrl]];
    [URL appendString:[self getRequestUrl]];
    return URL.copy;
}
// 得到基本的URL 一般根据 getBasetUrlType 来进行配置
- (NSString*)getBaseRequestUrl {
    return @"";
}

/**
 自定义完整的请求URL 实现该方法,getRequestUrl方法可以忽略
 
 @return 请求的URL,默认为nil;
 */
- (NSString *)absoluteRequestURL {
    return nil;
}

- (ZJBaseNetRequestType)getNetAdapterRequestType {
    return ZJBaseNetRequestTypePOST;
}

/**
 参数是否需要加签
 @return YES/NO
 */
- (BOOL)isSignatureParamters {
    return false;
}

/**
 是否需要Token
 @return YES/NO
 */
- (BOOL)isNeedToken {
    return false;
}

/**
 基本参数

 @return 字典
 */
- (NSDictionary *)basicParams {
    return @{};
}

- (Class)getResponseClass {
    return nil;
}


/**
 拼接参数
 @return 完整参数字典
 */
- (NSMutableDictionary *)parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    if (_paramModel) {
        [parameters addEntriesFromDictionary:[_paramModel modelToJSONObject]];
        //[self basicParams]
        [parameters addEntriesFromDictionary:[self basicParams]];
    }
    if (self.isSignatureParamters) {
//        parameters = [self signatureParameters:parameters];
    }
    return parameters;
}

#pragma mark - 子类非必须覆写
//获取基本请求类型
- (ZJBaseUrlType)getBasetUrlType {
    return ZJBaseUrlTypeNormal;
}

- (ZJRequestCache *)requestCache{
    if(!_requestCache){
        _requestCache = [ZJRequestCache new];
        _requestCache.openCache = false;
    }
    return _requestCache;
}
- (AFHTTPSessionManager *)pManager{
    if(!_pManager){
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/json",@"text/plain",@"image/*", nil];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        manager.securityPolicy.allowInvalidCertificates = true;
        manager.securityPolicy.validatesDomainName = false;
        manager.requestSerializer.timeoutInterval  = [self getTimeoutInterval];
        _pManager = manager;
    }
    return _pManager;
}

- (AFHTTPSessionManager *)uploadManager{
    if(!_uploadManager){
        //4. 发起网络请求
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer    = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        manager.securityPolicy.allowInvalidCertificates = true;
        manager.securityPolicy.validatesDomainName = false;
        _uploadManager = manager;
    }
    return _uploadManager;
}


@end
