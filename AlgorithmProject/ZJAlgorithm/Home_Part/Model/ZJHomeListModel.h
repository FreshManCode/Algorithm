//
//  ZJHomeListModel.h
//  ZJAlgorithm
//
//  Created by 张君君 on 2020/3/30.
//  Copyright © 2020年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseNetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJHomeListModel : ZJBaseNetModel

@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, copy) NSString *pushClassName;

+ (instancetype)initWithBookName:(NSString *)bookName
                   pushClassName:(NSString *)pushClassName;


@end

NS_ASSUME_NONNULL_END
