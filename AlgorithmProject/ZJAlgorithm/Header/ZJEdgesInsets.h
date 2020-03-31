//
//  ZJEdgesInsets.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  struct ZJCellEdgeinset {
    CGFloat left;
    CGFloat right;
} ZJCellEdgeinset ;


static inline ZJCellEdgeinset ZJEdgeInsetsMake(CGFloat left, CGFloat right) {
    ZJCellEdgeinset inset;
    inset.left = left;
    inset.right = right;
    return inset;
}
