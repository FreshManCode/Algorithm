//
//  ZJCommonMacros.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  存放一些宏定义


#define ZJColorWithHex(value) [UIColor \
colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 \
green:((float)((value & 0xFF00) >> 8))/255.0 \
blue:((float)(value & 0xFF))/255.0 alpha:1.0]

#define ZJRGBColor(r,g,b) [UIColor \
colorWithRed:r/255.0 \
green:g/255.0 \
blue:b/255.0 alpha:1.0]

#define ZJColorWithHexA(value,a) [UIColor \
colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 \
green:((float)((value & 0xFF00) >> 8))/255.0 \
blue:((float)(value & 0xFF))/255.0 alpha:a]

#define ZJFont(a)     [UIFont systemFontOfSize:a]
#define ZJBFont(a)    [UIFont boldSystemFontOfSize:a]


// 打印日志
#ifdef  DEBUG
#define ZJNSLOG(...) NSLog(@"<<DG>>%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#elif   PRERELEASE
#define ZJNSLOG(...) NSLog(@"<<PE>>%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#elif   COMMONDEBUG
#define ZJNSLOG(...) NSLog(@"<<CG>>%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
//#define ZJNSLOG(...)

#else
#define ZJNSLOG(...)
#endif

#define ZJISIPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define ZJISIPhoneXSMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define ZJISIphoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define ZJISIPhoneXS ZJISIphoneX

#define ZJIPhoneX (( ZJISIPhoneXR || ZJISIphoneX || ZJISIPhoneXSMax || ZJISIPhoneXS) ? YES : NO)

// 状态栏高度
#define ZJStatusBarHeight        (ZJIPhoneX ? 44.f : 20.f)
// 导航栏高度
#define ZJNavgationBarHeight     (ZJIPhoneX ? 88.f : 64.f)
// tabBar高度
#define ZJTabBarHeight           (ZJIPhoneX ? (49.f + 34.f) : 49.f)
// home indicator
#define ZJHOME_INDICATOR_HEIGHT  (ZJIPhoneX ? 34.f : 0.f)

#define ZJScreenHeight [[UIScreen mainScreen]bounds].size.height//屏幕高度

#define ZJScreenWidth  [[UIScreen mainScreen]bounds].size.width//屏幕宽度

#define ZJ_ONE_PIXEL (1 / [UIScreen mainScreen].scale)


//以Iphone6位基准的宽度Ratio
#define ZJIphone6WRatio  (ZJScreenWidth / 375.f )

#define ZJIphone6HRatio  (ZJScreenHeight / 667.f )

#define ZJIphone6Height (667.f)

/**
 回到主线程
 
 @param block 主线程的Block
 @return 主线程实例
 */
#define ZJDispatch_asyncMain(block) dispatch_async(dispatch_get_main_queue(),block)

/**
 子线程实例
 
 @param block 子线程Block
 @return 子线程实例
 */
#define ZJDispatch_async(block)     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);

/**
 延迟调用
 
 @param time 延迟时间
 @param block 主线程的block
 @return 延迟block
 */
#define ZJGCDAferTimer(time,block)  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),dispatch_get_main_queue(),block)



#define ZJDefaultBackColor ZJColorWithHex(0xF6F6F8)
#define ZJ4ATitleColor     ZJColorWithHex(0x4A4A4A)
//浅蓝色
#define ZJLightBlueColor   ZJColorWithHex(0x89B4E6)
#define ZJ9BTitleColor     ZJColorWithHex(0x9B9B9B)
#define ZJECLineColor      ZJColorWithHex(0xECECEC)

#define ZJLightBackColor         ZJColorWithHexA(0x000000, 0.5)
#define ZJAlphaBackgroundColor   ZJColorWithHexA(0x000000, 0.5)


#define kZJ1PX ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)






