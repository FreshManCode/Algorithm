//
//  ZJBaseCommand.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/21.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseCommand.h"

@implementation ZJBaseCommand

/**
 返回按钮事件
 
 @param fromVC 从哪个ViewController 发起
 */
- (void)zj_backButtonEvent:(UIViewController *)fromVC {
    ZJNSLOG(@"%@",@"ZJBaseCommand---zj_backButtonEvent");
    [fromVC.navigationController popViewControllerAnimated:true];
}


/**
 push/Pop到指定Controller
 
 @param fromVC 从哪个界面发起
 */
- (void)zj_pushToSepecificViewController:(UIViewController *)fromVC {
    ZJNSLOG(@"%@",@"ZJBaseCommand---zj_pushToSepecificViewController");
}


@end
