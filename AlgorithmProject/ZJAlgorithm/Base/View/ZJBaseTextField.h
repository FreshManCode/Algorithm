//
//  ZJBaseTextField.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//  输入框基类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTextField : UITextField

@property (nonatomic,weak) id <UITextFieldDelegate> pDelegate;
@property (nonatomic, assign) NSInteger maxCount;

/**是否允许长按弹出 Copy等相关选择框 (YES/NO)*/
@property (nonatomic, assign) BOOL allowCopyMenu;

@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeHolderColor;

- (BOOL)isReachMaxCountCharacterRange:(NSRange)range replacmentString:(NSString *)string;


@end

NS_ASSUME_NONNULL_END
