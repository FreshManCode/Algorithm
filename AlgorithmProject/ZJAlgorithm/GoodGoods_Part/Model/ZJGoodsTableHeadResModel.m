//
//  ZJGoodsTableHeadResModel.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/4.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJGoodsTableHeadResModel.h"

/*
 ZJGoodsTableHeadBannerListModel
 ZJGoodsTableHeadBannerListLicenseModel
 ZJGoodsTableHeadBannerListParamModel
 ZJGoodsTableHeadCategoryListModel
 ZJGoodsTableHeadDynamicTextItemModel
 ZJGoodsTableHeadDynamicListsModel
 
 */

@implementation ZJGoodsTableHeadBannerListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"param":[ZJGoodsTableHeadBannerListParamModel class],
             @"license":[ZJGoodsTableHeadBannerListLicenseModel class],
             };
}

@end

@implementation ZJGoodsTableHeadBannerListLicenseModel

@end


@implementation ZJGoodsTableHeadDynamicItemModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"text_info":[ZJGoodsTableHeadDynamicTextItemModel class]};
}


@end

@implementation ZJGoodsTableHeadBannerListParamModel

@end

@implementation ZJGoodsTableHeadCategoryListModel

@end

@implementation ZJGoodsTableHeadDynamicTextItemModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"text_info":[ZJGoodsTableHeadDynamicTextItemModel class]};
}

@end

@implementation ZJGoodsTableHeadDynamicListsModel

@end


@implementation ZJGoodsTableHeadSecondListItemModel

@end

@implementation ZJGoodsTableHeadResModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"n_dynamic_list":@"new_dynamic_list",
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"banner_list":[ZJGoodsTableHeadBannerListModel class],
             @"category_list":[ZJGoodsTableHeadCategoryListModel class],
             @"n_dynamic_list":[ZJGoodsTableHeadDynamicListsModel class],
             @"second_banner_list":[ZJGoodsTableHeadSecondListItemModel class],
             };
}

@end
