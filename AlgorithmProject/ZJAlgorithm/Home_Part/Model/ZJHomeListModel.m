//
//  ZJHomeListModel.m
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/30.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJHomeListModel.h"

@implementation ZJHomeListModel

+ (instancetype)initWithBookName:(NSString *)bookName
                   pushClassName:(NSString *)pushClassName {
    ZJHomeListModel *homeListModel = [ZJHomeListModel new];
    [homeListModel setBookName:bookName];
    [homeListModel setPushClassName:pushClassName];
    return homeListModel;
}

@end
