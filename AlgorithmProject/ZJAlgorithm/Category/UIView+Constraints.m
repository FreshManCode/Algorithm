//
//  UIView+Constraints.m
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/22.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import "UIView+Constraints.h"
#import <objc/runtime.h>

static NSString * const kPathKey  = @"UIBEZIERPathKey";
static NSString * const kLayerKey = @"CAShapeLayerKey";

@implementation UIView (Constraints)

+ (Class )layerClass {
    return [CAShapeLayer class];
}

- (UIBezierPath *)path {
    return objc_getAssociatedObject(self, &kPathKey);
}

- (void)setPath:(UIBezierPath *)path {
    objc_setAssociatedObject(self, &kPathKey, path, OBJC_ASSOCIATION_RETAIN);
}

- (CAShapeLayer *)shapeLayer {
    CAShapeLayer * layer = objc_getAssociatedObject(self, &kLayerKey);
    if (!layer) {
        layer = [CAShapeLayer layer];
        [self setShapeLayer:layer];
    }
    return objc_getAssociatedObject(self, &kLayerKey);
}

- (void)setShapeLayer:(CAShapeLayer *)shapeLayer {
    objc_setAssociatedObject(self, &kLayerKey, shapeLayer, OBJC_ASSOCIATION_RETAIN);
}


- (void)setX:(CGFloat)x {
    CGRect  frame  = self.frame;
    frame.origin.x = x;
    self.frame     = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame   = self.frame;
    frame.origin.y = y;
    self.frame     = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x       = centerX;
    self.center    = center;
}

- (CGFloat )centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center   = self.center;
    center.y         = centerY;
    self.center      = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame     = self.frame;
    frame.size.width = width;
    self.frame       = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame      = self.frame;
    frame.size.height = height;
    self.frame        = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame    = self.frame;
    frame.size      = size;
    self.frame      = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setTop:(CGFloat)top {
    CGRect frame   = self.frame;
    frame.origin.y = top;
    self.frame     = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame   = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame     = frame;
}

- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left {
    CGRect   frame = self.frame;
    frame.origin.x = left;
    self.frame     = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setSubScrollsToTop:(BOOL)scrollsToTop {
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)obj setScrollEnabled:scrollsToTop];
            *stop = YES;
        }
    }];
}

- (void)addCornerRadius:(CGFloat)radius {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;

    self.layer.mask = shapeLayer;
}

- (void)setHRCornerRadius:(CGFloat)radius
                fillColor:(UIColor *)fillColor
                lineColor:(UIColor *)lineColor
                lineWidth:(CGFloat)width {
    UIBezierPath *bizerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    CAShapeLayer *layer     = [CAShapeLayer layer];
    layer.fillColor         = fillColor.CGColor;
    layer.strokeColor       = lineColor.CGColor;
    layer.lineWidth         = width;
    layer.path              = bizerPath.CGPath;
    [self.layer addSublayer:layer];
}

- (CGFloat)getNavHeight {
    return CGRectGetHeight([[[[self currentVC] navigationController] navigationBar] frame]) + CGRectGetHeight([[UIApplication sharedApplication]statusBarFrame]);
}

- (UIViewController *)currentVC {
    for (UIView * next = [self superview]; next; next = next.superview ) {
        UIResponder *responsder = [next nextResponder];
        if ([responsder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *) responsder;
        }
    }
    return nil;
}

- (void)addCustomLayerCorner:(CGFloat)corner
                 borderColor:(UIColor *)borderColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corner];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor= borderColor.CGColor;
    shapeLayer.cornerRadius = corner;
    shapeLayer.lineCap  = kCALineCapRound;
    shapeLayer.lineJoin = kCALineCapRound;
    shapeLayer.lineWidth= 1.2f;
    ((CAShapeLayer *)self.layer).path = path.CGPath;
}

/**
 四个角添加圆角
 
 @param corner 弧度
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (void)addCustomLayerCorner:(CGFloat)corner
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corner];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor= borderColor.CGColor;
    shapeLayer.cornerRadius = corner;
    shapeLayer.lineCap  = kCALineCapRound;
    shapeLayer.lineJoin = kCALineCapRound;
    shapeLayer.lineWidth= borderWidth;
    shapeLayer.path = path.CGPath;
    ((CAShapeLayer *)self.layer).path = path.CGPath;
}
/**
 添加圆角 (默认没有边框)
 
 @param corner 弧度
 */
- (void)addCustomCorner:(CGFloat)corner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:corner];
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    shapeLayer.cornerRadius = corner;
    shapeLayer.lineCap  = kCALineCapRound;
    shapeLayer.lineJoin = kCALineCapRound;
    ((CAShapeLayer *)self.layer).path = path.CGPath;
}

- (void)resetShapeLayerPath {
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    if (shapeLayer.path) {
        shapeLayer.path = [[UIBezierPath new] CGPath];
    }
}

- (void)addTopCorner:(CGFloat)corner {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

/**
 给下部门的两个角添加圆角
 
 @param corner 弧度
 */
- (void)addBottomCorner:(CGFloat)corner {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}


/**
 仅仅添加圆角
 
 @param corner 圆角弧度
 */
- (void)onlyAddCornerRadius:(CGFloat)corner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    cornerRadius:corner];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.cornerRadius = corner;
    shapeLayer.lineCap  = kCALineCapRound;
    shapeLayer.lineJoin = kCALineCapRound;
    shapeLayer.path     = path.CGPath;
    self.layer.mask     = shapeLayer;
}


/**
 添加上半部分圆角 (默认没有边框)
 
 @param corner 弧度
 */
- (void)addTopCustomCorner:(CGFloat)corner {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.cornerRadius = corner;
    shapeLayer.lineCap  = kCALineCapRound;
    shapeLayer.lineJoin = kCALineCapRound;
    shapeLayer.path     = path.CGPath;
    self.layer.mask     = shapeLayer;
}

@end
