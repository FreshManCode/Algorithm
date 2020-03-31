//
//  ITRowModel.h
//  ImitateBaiduCourse
//
//  Created by SnailJob on 17/10/31.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITRowModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *name;


@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, assign,readonly) CGFloat nameH;

@property (nonatomic, assign,readonly) CGFloat textH;


- (CGSize)sizeWithModel:(ITRowModel *)model;

- (CGSize)sizeWithText:(NSString *)text;

@end
