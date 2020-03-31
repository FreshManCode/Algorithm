//
//  ZJBaseNavgationController.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/22.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJBaseNavgationController.h"
#import "ZJCommonMacros.h"

@interface ZJBaseNavgationController () <UINavigationControllerDelegate>
/**记录是否进行Push操作*/
@property (nonatomic, assign,getter = isPush) BOOL push;

@end

@implementation ZJBaseNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegate:self];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated {
    if (self.isPush && [self.viewControllers indexOfObject:viewController] != NSNotFound) {
        ZJNSLOG(@"拦截到重复跳转---%@",self);
        return;
    }
    if (self.childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = true;
    } else {
        
    }
    [super pushViewController:viewController animated:animated];
}

// MARK: - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [self setPush:true];
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    [self setPush:false];
}


@end
