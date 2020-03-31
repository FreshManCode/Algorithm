//
//  ZJFont.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJFont.h"

@implementation ZJFont


//系统字体
UIFont *ZJ_Font(CGFloat size) {
    return [UIFont systemFontOfSize:size];
}

//系统加粗
UIFont *ZJ_BFont(CGFloat size) {
    return [UIFont boldSystemFontOfSize:size];
}

//平方字体（IOS9）
UIFont *ZJ_PFont(CGFloat size) {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
}

UIKIT_EXTERN UIFont *ZJ_PSFont(CGFloat size) {
    return ZJ_PFont(size);
}

//PingFangSC-Regular 字体
UIFont *ZJ_PRFont(CGFloat size) {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

//PingFangSC-Medium 字体
UIFont *ZJ_PMFont(CGFloat size) {
    return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}
//左对齐Label
UILabel *ZJ_LeftAlignmentLabel(UIFont *font,UIColor *textColor) {
    UILabel *leftLabel = [UILabel new];
    leftLabel.font = font;
    leftLabel.textColor = textColor;
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.adjustsFontSizeToFitWidth = true;
    //宽度不够狗时压缩
    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //宽度够时正常显示
    [leftLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return leftLabel;
}

//右对齐Label
UILabel *ZJ_RightAlignmentLabel(UIFont *font,UIColor *textColor) {
    UILabel *rightLabel = [UILabel new];
    rightLabel.font     = font;
    rightLabel.textColor = textColor;
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.adjustsFontSizeToFitWidth = true;
    //宽度不够狗时压缩
    [rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //宽度够时正常显示
    [rightLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return rightLabel;
}

//居中对齐Label
UILabel *ZJ_CenterAlignmentLabel(UIFont *font,UIColor *textColor) {
    UILabel *centerLabel = [UILabel new];
    centerLabel.font = font;
    centerLabel.textColor = textColor;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.adjustsFontSizeToFitWidth = true;
    //宽度不够狗时压缩
    [centerLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //宽度够时正常显示
    [centerLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    return centerLabel;
}

//左对齐Label  (尽量完全显示,不压缩显示)
UIKIT_EXTERN UILabel *ZJ_LeftAliLabelNoCompress(UIFont *font,UIColor *textColor) {
    UILabel *lablel = ZJ_LeftAlignmentLabel(font,textColor);
    [lablel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    lablel.adjustsFontSizeToFitWidth = false;
    return lablel;
}
//右对齐Label  (尽量完全显示,不压缩显示)
UIKIT_EXTERN UILabel *ZJ_RightAliLabelNoCompress(UIFont *font,UIColor *textColor) {
    UILabel *lablel = ZJ_RightAlignmentLabel(font,textColor);
    [lablel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    lablel.adjustsFontSizeToFitWidth = false;
    return lablel;
}

//居中对齐Label (尽量完全显示,不压缩显示)
UIKIT_EXTERN UILabel *ZJ_CenterAliLabelNoCompress(UIFont *font,UIColor *textColor) {
    UILabel *lablel = ZJ_CenterAlignmentLabel(font,textColor);
    [lablel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    lablel.adjustsFontSizeToFitWidth = false;
    return lablel;
}


/**
 
 加载图片
 @param imageName 图片名称
 @return 对应的图片
 */
UIKIT_EXTERN UIImage *ZJ_LoadImage(NSString *imageName) {
    return [UIImage imageNamed:imageName];
}

/**
 默认展位图片
 
 @return 图片
 */
UIKIT_EXTERN UIImage *ZJDefaultPlahoder() {
    return ZJ_LoadImage(@"placeholder");
}

/**
 获取Window
 
 @return window
 */
UIKIT_EXTERN UIWindow *ZJ_AppWindow(void) {
    return [[UIApplication sharedApplication].delegate window];
}


/**
 把 view 添加到Window 上
 
 @param view 要添加的子视图
 */
UIKIT_EXTERN void ZJ_AddSubviewInWinodw(UIView *view) {
    if (view) {
        [ZJ_AppWindow() addSubview:view];
    }
}

@end
