//
//  ITRowModel.m
//  ImitateBaiduCourse
//
//  Created by SnailJob on 17/10/31.
//  Copyright © 2017年 能伍网络. All rights reserved.
//

#import "ITRowModel.h"
#import "NSObject+YWMethodAddition.h"

#define kMaxWidth  floorf((ZJScreenWidth - 30 )/2.0)


@implementation ITRowModel

static NSString * const kName = @"Name";

- (CGSize)sizeWithModel:(ITRowModel *)model {
    return [self sizeWithText:model.text];
}


- (CGSize)sizeWithText:(NSString *)text {
    
    CGFloat top  = 15.f;
    
    CGSize label1H = [self attributionHeightWithString:kName
                                             lineSpace:5.f
                                                  font:ZJFont(15.f)
                                                 width:kMaxWidth - 2 * 15];
    _nameH = label1H.height;
    
    CGSize label2H = [self attributionHeightWithString:text
                                             lineSpace:5.f
                                                  font:ZJFont(15.f)
                                                 width:kMaxWidth -  2 * 15];
    CGFloat height = top +label1H.height +  15 + label2H.height + 15;
    
    _textH = label2H.height;
    
    return CGSizeMake(kMaxWidth, height) ;
    
}


@end
