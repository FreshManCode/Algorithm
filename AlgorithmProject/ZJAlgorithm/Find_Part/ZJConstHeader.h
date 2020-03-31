//
//  ZJConstHeader.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/31.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJBaseTableView.h"
#import "ZJSegmentPageViewController.h"
#import "ZJSearchView.h"
#import "ZJCategoryView.h"

//搜索栏高度
static CGFloat const kSearchViewH = 40.f;
//搜索栏与标签之间的距离
static CGFloat const kViewGap = 30.f;
//标签宽度
static CGFloat const kCategoryItemW = 48.f;
//标签正常宽度
static CGFloat const kCategoryNormalItemW = kCategoryItemW;

//大Cell的ID
static NSString * const KCellID = @"BigCEllID";

#define kDefaultCategoryViewH 40.f

#define kTopViewH (kSearchViewH + kDefaultCategoryViewH + kViewGap )


