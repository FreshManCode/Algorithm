//
//  ZJMainTabBarViewController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJMainTabBarViewController.h"
#import "ZJBaseNavgationController.h"
#import "ZJLibsHeader.h"
#import "ZJFinderHomeViewController.h"
#import "ZJGoodsHomeViewController.h"
#import "ZJHomeViewController.h"


@interface ZJMainTabBarViewController ()

@end

@implementation ZJMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpMainRootViewController];
}

- (void)setUpMainRootViewController {
    UINavigationController *homeNav = [self setUpWithTitle:@"首页"
                                                 normalImage:@"Home_Normal"
                                                   highImage:@"Home_High"
                                                  controller:[ZJHomeViewController new]];
    
    UINavigationController *finderNav = [self setUpWithTitle:@"发现"
                                                 normalImage:@"Finder_Normal"
                                                   highImage:@"Finder_High"
                                                  controller:[ZJFinderHomeViewController new]];
    UINavigationController *goodsNav = [self setUpWithTitle:@"好货"
                                                 normalImage:@"Goods_Normal"
                                                   highImage:@"Goods_High"
                                                  controller:[ZJGoodsHomeViewController new]];
    [self setViewControllers:@[homeNav,finderNav,goodsNav]];
}


- (UINavigationController *)setUpWithTitle:(NSString *)title
                               normalImage:(NSString *)normalImage
                                 highImage:(NSString *)highImage
                                controller:(UIViewController *)viewController{
    ZJBaseNavgationController *navController = [[ZJBaseNavgationController alloc]
                                                initWithRootViewController:viewController];
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [ZJ_LoadImage(normalImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [ZJ_LoadImage(highImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navController setNavigationBarHidden:true animated:false];
    return navController;
}


@end
