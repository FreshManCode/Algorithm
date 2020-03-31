//
//  ZJBaseTextField.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTextField.h"

@interface ZJTextFieldHelper : NSObject <UITextFieldDelegate>
@property (nonatomic, strong) ZJBaseTextField *textField;

@end

@implementation ZJTextFieldHelper

- (instancetype)initWithTextField:(ZJBaseTextField *)textField {
    if (self = [super init]) {
        self.textField = textField;
        self.textField.delegate = self;
    }
    return self;
}

// MARK: - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    id <UITextFieldDelegate > pDelegate =  [(ZJBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        [pDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    ZJBaseTextField *p_textField = (ZJBaseTextField *)textField;
    //  判断是否达到设定的最大值
    if ([p_textField isReachMaxCountCharacterRange:range replacmentString:string ]) {
        return NO;
    }
    return true;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id <UITextFieldDelegate>pDelegate = [(ZJBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [pDelegate textFieldShouldClear:textField];
    }
    return true;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id <UITextFieldDelegate>pDelegate = [(ZJBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [pDelegate textFieldShouldBeginEditing:textField];
    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id <UITextFieldDelegate>pDelegate = [(ZJBaseTextField *)textField pDelegate];
    if ([pDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [pDelegate textFieldShouldEndEditing:textField];
    }
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((ZJBaseTextField*)textField).pDelegate;
    if([pDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [pDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((ZJBaseTextField*)textField).pDelegate;
    if([pDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [pDelegate textFieldShouldReturn:textField];
    }
    return YES;
}


@end

@interface ZJBaseTextField ()

@property (nonatomic, strong) ZJTextFieldHelper *fieldHelper;

@end


@implementation ZJBaseTextField

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self zj_setPlanceHolder];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    [self zj_setPlanceHolder];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if (self.placeholderFont && self.placeHolderColor) {
        [self zj_setPlanceHolder];
    }
}

- (void)zj_setPlanceHolder {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.placeholder ?: @""];
    if (self.placeholderFont) {
        [attr addAttribute:NSFontAttributeName value:self.placeholderFont range:[attr.string rangeOfString:attr.string]];
    }
    if (self.placeHolderColor) {
        [attr addAttribute:NSForegroundColorAttributeName value:self.placeHolderColor range:[attr.string rangeOfString:attr.string]];
    }
    self.attributedPlaceholder = attr.copy;
}



- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)p_defaultInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    _maxCount = 0;
    _fieldHelper = [[ZJTextFieldHelper alloc] initWithTextField:self];
}


- (BOOL)isReachMaxCountCharacterRange:(NSRange)range replacmentString:(NSString *)string {
    if (self.maxCount < 1) {
        return false;
    }
    NSString *new_string = [self.text stringByReplacingCharactersInRange:range withString:string];
    if (new_string.length > _maxCount) {
        return YES;
    }
    return false;
}

- (void)textFieldChanged:(UITextField *)textField {
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.allowCopyMenu) {
        return [super canPerformAction:action withSender:sender];
    }
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        menuController.menuVisible = NO;
    }
    return false;
}



@end
