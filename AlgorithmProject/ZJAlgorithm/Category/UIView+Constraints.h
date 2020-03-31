//
//  UIView+Constraints.h
//  ImitateBaiduCourse
//
//  Created by 杨冠军 on 16/7/22.
//  Copyright © 2016年 豆梦霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraints)

@property (nonatomic, strong,readonly) UIBezierPath *path;
@property (nonatomic, strong,readonly) CAShapeLayer *shapeLayer;


@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

- (void)setSubScrollsToTop:(BOOL)scrollsToTop;

- (void)addCornerRadius:(CGFloat)radius;

- (void)setHRCornerRadius:(CGFloat)radius
                fillColor:(UIColor *)fillColor
                lineColor:(UIColor *)lineColor
                lineWidth:(CGFloat)width;


- (CGFloat)getNavHeight;


/**
 添加圆角

 @param corner 弧度
 @param borderColor 边框颜色 (边框宽度默认1.f)
 */
- (void)addCustomLayerCorner:(CGFloat)corner
                 borderColor:(UIColor *)borderColor;


/**
 四个角添加圆角

 @param corner 弧度
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (void)addCustomLayerCorner:(CGFloat)corner
                 borderWidth:(CGFloat)borderWidth
                 borderColor:(UIColor *)borderColor;


/**
 添加圆角 (默认没有边框)

 @param corner 弧度
 */
- (void)addCustomCorner:(CGFloat)corner;

/**
 给上部分两个角添加圆角

 @param corner 弧度
 */
- (void)addTopCorner:(CGFloat)corner;


/**
 给下部门的两个角添加圆角

 @param corner 弧度
 */
- (void)addBottomCorner:(CGFloat)corner;



/**
 仅仅添加圆角

 @param corner 圆角弧度
 */
- (void)onlyAddCornerRadius:(CGFloat)corner;


/**
 添加上半部分圆角 (默认没有边框)
 
 @param corner 弧度
 */
- (void)addTopCustomCorner:(CGFloat)corner;


@end
