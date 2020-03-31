//
//  ZJFont.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJFont : NSObject

//系统字体
UIKIT_EXTERN UIFont *ZJ_Font(CGFloat size);

//系统加粗
UIKIT_EXTERN UIFont *ZJ_BFont(CGFloat size);

//平方字体（IOS9）
//PingFangSC-Semibold
UIKIT_EXTERN UIFont *ZJ_PFont(CGFloat size);

//PingFangSC-Semibold
UIKIT_EXTERN UIFont *ZJ_PSFont(CGFloat size);

//PingFangSC-Regular 字体
UIKIT_EXTERN UIFont *ZJ_PRFont(CGFloat size);

//PingFangSC-Medium 字体
UIKIT_EXTERN UIFont *ZJ_PMFont(CGFloat size);


//左对齐Label (显示不全就压缩显示)
UIKIT_EXTERN UILabel *ZJ_LeftAlignmentLabel(UIFont *font,UIColor *textColor);
//右对齐Label (显示不全就压缩显示)
UIKIT_EXTERN UILabel *ZJ_RightAlignmentLabel(UIFont *font,UIColor *textColor);

//居中对齐Label (显示不全就压缩显示)
UIKIT_EXTERN UILabel *ZJ_CenterAlignmentLabel(UIFont *font,UIColor *textColor);


//左对齐Label  (尽量完全显示,不压缩显示)
UIKIT_EXTERN UILabel *ZJ_LeftAliLabelNoCompress(UIFont *font,UIColor *textColor);
//右对齐Label  (尽量完全显示,不压缩显示)
UIKIT_EXTERN UILabel *ZJ_RightAliLabelNoCompress(UIFont *font,UIColor *textColor);

//居中对齐Label (尽量完全显示,不压缩显示)
UIKIT_EXTERN UILabel *ZJ_CenterAliLabelNoCompress(UIFont *font,UIColor *textColor);


/**
 
 加载图片
 @param imageName 图片名称
 @return 对应的图片
 */
UIKIT_EXTERN UIImage *ZJ_LoadImage(NSString *imageName);


/**
 默认展位图片

 @return 图片
 */
UIKIT_EXTERN UIImage *ZJDefaultPlahoder();


/**
 获取Window

 @return window
 */
UIKIT_EXTERN UIWindow *ZJ_AppWindow(void);


/**
 把 view 添加到Window 上

 @param view 要添加的子视图
 */
UIKIT_EXTERN void ZJ_AddSubviewInWinodw(UIView *view);





@end

NS_ASSUME_NONNULL_END
