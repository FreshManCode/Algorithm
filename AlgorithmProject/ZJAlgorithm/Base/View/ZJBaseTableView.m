//
//  ZJBaseTableView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseTableView.h"
#import "ZJConstHeader.h"

@interface ZJBaseTableView ()

@end

@implementation ZJBaseTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_ZJDelegate && [_ZJDelegate respondsToSelector:@selector(zj_tableviewTouchBegan:)]) {
        [self.ZJDelegate zj_tableviewTouchBegan:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 仅仅让pageViewController区域的多个手势共存, 解决分页以上部分的"横向滑动视图(嵌套UICollectionView)"和scrollView的纵向滑动的手势冲突问题
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    CGFloat segmentViewContentScrollViewHeight = self.tableFooterView.frame.size.height - self.categoryViewHeight ?: kDefaultCategoryViewH;
    BOOL isContainsPoint = CGRectContainsPoint(CGRectMake(0, self.contentSize.height - segmentViewContentScrollViewHeight, ZJScreenWidth, segmentViewContentScrollViewHeight), currentPoint);
    return isContainsPoint ? YES : NO;
}


@end
