//
//  ZJSearchView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJSearchView.h"
#import "UIView+Constraints.h"
#import "ZJBaseTextField.h"

@interface ZJSearchView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) ZJBaseTextField *searchFiled;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation ZJSearchView


- (void)zj_addSubviews {
    self.containerView = [UIView new];
    [self.containerView setBackgroundColor:ZJECLineColor];
    [self addSubview:self.containerView];
    
    self.iconView = [UIImageView new];
    [self.iconView setImage:ZJ_LoadImage(@"SearchContactsBarIcon")];
    [self.containerView addSubview:self.iconView];
    
    self.searchFiled = [ZJBaseTextField new];
    [self.searchFiled setDelegate:self];
    [self.searchFiled setPlaceholder:@"搜索哦"];
    [self.searchFiled setPlaceholderFont:ZJFont(15.f)];
    [self.searchFiled setPlaceHolderColor:[UIColor lightGrayColor]];
    self.searchFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchFiled setTextAlignment:NSTextAlignmentLeft];
    [self.searchFiled setReturnKeyType:UIReturnKeySearch];
    self.searchFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.containerView addSubview:self.searchFiled];
    self.searchFiled.tintColor = [UIColor lightGrayColor];
    [self.searchFiled addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setHidden:true];
    [self.containerView addSubview:self.cancelButton];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

- (void)zj_addConstraints {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(35);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.searchFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(2);
        make.centerY.mas_equalTo(0);
        make.height.equalTo(self.containerView);
        make.right.equalTo(self.containerView.mas_right).offset(-1);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
}

- (void)cancelEvent:(UIButton *)sender {
    [self setShowCancelButton:false];
    [self endEditing:true];
    NSLog(@"取消搜索");
}

- (void)setShowCancelButton:(BOOL)showCancelButton {
    _showCancelButton = showCancelButton;
    [self.cancelButton setHidden:!showCancelButton];
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(35);
        if (showCancelButton) {
            make.right.equalTo(self.cancelButton.mas_left).offset(-10);
        }
        else {
            make.right.mas_equalTo(-10);
        }
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.containerView onlyAddCornerRadius:4.f];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setShowCancelButton:true];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setShowCancelButton:false];
    NSLog(@"%@",textField.text);
}

- (void)textFiledChanged:(UITextField *)textField {
    if (textField.text.length >0) {
        //获取是否有高亮 (如果是中文的时候,会有这个高亮区域)
        UITextRange *selectedRange = [self.searchFiled markedTextRange];
        if (!selectedRange) {
            NSLog(@"可以开始搜索:%@",textField.text);
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"可以开始搜索:%@",textField.text);
    return false;
}




@end
