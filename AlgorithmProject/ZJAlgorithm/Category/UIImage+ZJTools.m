//
//  UIImage+ZJTools.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/4/8.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "UIImage+ZJTools.h"
#import "NSString+ZJTools.h"

@implementation UIImage (ZJTools)

/**
 添加文字水印
 
 @param text text
 */
- (UIImage *)addMaskText:(NSString *)text {
    CGFloat imageW = self.size.width;
    CGFloat imageH = self.size.height;
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, imageW, imageH)];
//    [text drawInRect:CGRectMake(0, 10, imageW, 20) withAttributes:@{NSFontAttributeName:ZJFont(15.f),NSForegroundColorAttributeName:[UIColor redColor]}];
    [text drawInRect:CGRectMake(0, 10, imageW, 20) withAttributes:[self attributesWithText:text]];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}





- (NSMutableDictionary *)attributesWithText:(NSString *)text {
    // 文本段落样式
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping; // 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    textStyle.alignment = NSTextAlignmentRight; //（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    textStyle.lineSpacing = 5; // 字体的行间距
    textStyle.firstLineHeadIndent = 5.0; // 首行缩进
    textStyle.headIndent = 0.0; // 整体缩进(首行除外)
    textStyle.tailIndent = 0.0; //
    textStyle.minimumLineHeight = 20.0; // 最低行高
    textStyle.maximumLineHeight = 20.0; // 最大行高
    textStyle.paragraphSpacing = 15; // 段与段之间的间距
    textStyle.paragraphSpacingBefore = 22.0f; // 段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
    textStyle.baseWritingDirection = NSWritingDirectionLeftToRight; // 从左到右的书写方向（一共➡️三种）
    textStyle.lineHeightMultiple = 15; /* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
    textStyle.hyphenationFactor = 1; //连字属性 在iOS，唯一支持的值分别为0和1
    // 文本属性
    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] init];
    // NSParagraphStyleAttributeName 段落样式
    [textAttributes setValue:textStyle forKey:NSParagraphStyleAttributeName];
    // NSFontAttributeName 字体名称和大小
    [textAttributes setValue:[UIFont systemFontOfSize:12.0] forKey:NSFontAttributeName];
    // NSForegroundColorAttributeNam 颜色
    [textAttributes setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    // 绘制文字
    return textAttributes;
}
@end
