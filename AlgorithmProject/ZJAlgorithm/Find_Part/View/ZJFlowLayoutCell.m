//
//  ZJFlowLayoutCell.m
//  ImitateBaiduCourse
//
//  Created by 张君君 on 2019/10/23.
//  Copyright © 2019年 ZhangJunJun. All rights reserved.
//

#import "ZJFlowLayoutCell.h"
#import "ITRowModel.h"
#import <Masonry/Masonry.h>
#import "NSObject+YWMethodAddition.h"
#import "UIView+Constraints.h"
#import <YYKit/YYKit.h>
#import "ZJDiscoverlistItemModel.h"

@interface ZJFlowLayoutCell ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ZJFlowLayoutCell

- (void)zj_addSubviews {
    [self.contentView setBackgroundColor:ZJECLineColor];

    
    self.nameLab = [YYLabel new];
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.font = ZJFont(15.f);
    self.nameLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.nameLab];
    
    
    self.contentLab = [YYLabel new];
    self.contentLab.textAlignment = NSTextAlignmentLeft;
    self.contentLab.font = ZJFont(15.f);
    self.contentLab.textColor = [UIColor lightGrayColor];
    self.contentLab.preferredMaxLayoutWidth = (kScreenWidth - 30)/2.0 - 30;
    self.contentLab.numberOfLines = 0;
    [self.contentView addSubview:self.contentLab];
    
}
- (void)zj_addConstraints {
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
    }];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(15);
        make.left.equalTo(self.nameLab);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setRowModel:(ITRowModel *)model {
    [self loadText:model];
//    if (self.queue.operationCount >= 2) {
//        [self.queue cancelAllOperations];
//    }
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
//                                                                            selector:@selector(loadText:)
//                                                                              object:model];
//    [self.queue addOperation:operation];

}

- (void)loadText:(ITRowModel *)model {
    
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    NSMutableAttributedString *string1 = [ZJFlowLayoutCell getAttributeStringWithContent:model.name
                                                                             lineSpacing:5.f
                                                                                wordFont:ZJFont(15)];
    
    
    NSMutableAttributedString *string2 = [ZJFlowLayoutCell getAttributeStringWithContent:model.text
                                                                             lineSpacing:5.f
                                                                                wordFont:ZJFont(15)];
    
    [self.nameLab setAttributedText:string1];
    [self.contentLab setAttributedText:string2];
    //    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView onlyAddCornerRadius:4.f];
}

- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue  = [[NSOperationQueue alloc]init];
        //设置最大并行操作数为1相当于将queue设置为串行线程
        _queue.maxConcurrentOperationCount = 1;
    }
    return _queue;
}


@end
