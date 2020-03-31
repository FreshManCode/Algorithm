//
//  ZJGoodsTableHeadResModel.h
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/11/4.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//
/*
 ZJGoodsTableHeadBannerListModel
 ZJGoodsTableHeadBannerListLicenseModel
 ZJGoodsTableHeadBannerListParamModel
 ZJGoodsTableHeadCategoryListModel
 ZJGoodsTableHeadDynamicTextItemModel
 ZJGoodsTableHeadDynamicListsModel
 
 */

#import "ZJBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJGoodsTableHeadBannerListParamModel : ZJBaseModel

@property (nonatomic, copy) NSString *activity_id;
@property (nonatomic, copy) NSString *activity_name;
@property (nonatomic, copy) NSString *activity_url;
@property (nonatomic, copy) NSString *function_tapped;

@end

@interface ZJGoodsTableHeadBannerListLicenseModel : ZJBaseModel

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url_link;
@end

@interface ZJGoodsTableHeadBannerListModel : ZJBaseModel

@property (nonatomic, strong) ZJGoodsTableHeadBannerListParamModel *param;
@property (nonatomic, strong) ZJGoodsTableHeadBannerListLicenseModel *license;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *url;

@end



@interface ZJGoodsTableHeadCategoryListModel :ZJBaseModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *link_url;

@end

@interface ZJGoodsTableHeadDynamicTextItemModel :ZJBaseModel
@property (nonatomic, copy) NSString *icon_type;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *first_text;
@property (nonatomic, copy) NSString *middle_text;
@property (nonatomic, copy) NSString *last_text;
@property (nonatomic, copy) NSString *sub_text;



@end

@interface ZJGoodsTableHeadDynamicItemModel :ZJBaseModel
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *need_top_margin;
@property (nonatomic, strong) ZJGoodsTableHeadDynamicTextItemModel *text_info;
@property (nonatomic, copy) NSString *url;

@end




@interface ZJGoodsTableHeadDynamicListsModel :ZJBaseModel
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *need_top_margin;
@property (nonatomic, strong) ZJGoodsTableHeadDynamicTextItemModel *text_info;
@property (nonatomic, copy) NSString *url;

@end

@interface ZJGoodsTableHeadSecondListItemModel :ZJBaseModel
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *proportion;

@end


@interface ZJGoodsTableHeadResModel : ZJBaseModel

//banner图
@property (nonatomic, strong) NSArray <ZJGoodsTableHeadBannerListModel *> *banner_list;
@property (nonatomic, strong) NSArray *dynamic_list;
//滑动的小图
@property (nonatomic, strong) NSArray <ZJGoodsTableHeadCategoryListModel *> *category_list;
@property (nonatomic, strong) NSArray *roll_banner_list;
//高架求购,最新降价
@property (nonatomic, strong) NSArray <ZJGoodsTableHeadDynamicListsModel *> *n_dynamic_list;
//排序上的标签
@property (nonatomic, strong) NSArray <ZJGoodsTableHeadSecondListItemModel *> *second_banner_list;



@end

NS_ASSUME_NONNULL_END
