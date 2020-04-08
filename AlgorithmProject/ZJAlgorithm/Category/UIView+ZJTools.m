//
//  UIView+ZJTools.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/8.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "UIView+ZJTools.h"
#import <objc/runtime.h>

@implementation UIView (ZJTools)

static NSString * const ZJTapGestureKey = @"ZJTapGestureKey";
static NSString * const ZJButtonEvetKey = @"ZJButtonEvetKey";


- (ZJTapGesture)tapGesture {
    return objc_getAssociatedObject(self, &ZJTapGestureKey);
}

- (void)setTapGesture:(ZJTapGesture)tapGesture {
    objc_setAssociatedObject(self, &ZJTapGestureKey, tapGesture, OBJC_ASSOCIATION_COPY);
}


/**
 添加点击手势(单击)
 
 @param gesture 点击回调
 */
- (void)addTapGesture:(ZJTapGesture)gesture {
    self.userInteractionEnabled = true;
    self.tapGesture = gesture;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [self addGestureRecognizer:tapGesture];
}




/**
 添加双击手势(双击)
 
 @param gesture 点击回调
 */
- (void)addDoubleTapGesture:(ZJTapGesture)gesture {
    self.userInteractionEnabled = true;
    self.tapGesture = gesture;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    tapGesture.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapGesture];
}


- (void)tapEvent:(UITapGestureRecognizer *)gesture {
    !self.tapGesture ? : self.tapGesture (gesture);
}

@end
