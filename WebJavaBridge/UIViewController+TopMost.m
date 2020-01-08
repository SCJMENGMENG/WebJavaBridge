//
//  UIViewController+TopMost.m
//  NewsEarn
//
//  Created by zhubch on 2018/7/11.
//  Copyright © 2018年 CooHua. All rights reserved.
//

#import "UIViewController+TopMost.h"
#import "AppDelegate.h"

@implementation UIViewController(TopMost)

+ (UIViewController *)topMost {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}

+ (UITabBarController *)rootTabBarController {
    return [(AppDelegate *)[UIApplication sharedApplication].delegate tabbarController];
}

- (void)popToControllerClass:(Class)controllerClass {
    for (int i = 0; i < self.navigationController.viewControllers.count; i ++) {
        UIViewController *stackController = self.navigationController.viewControllers[i];
        if ([stackController isKindOfClass:[RTContainerController class]]) {
            stackController = [(RTContainerController *)stackController contentViewController];
        }
        if ([stackController isMemberOfClass:controllerClass]) {
            [self.rt_navigationController popToViewController:stackController animated:YES complete:nil];
            break;
        }
    }
}

- (void)popToControllerBeforeClass:(Class)controllerClass {
    for (int i = 0; i < self.navigationController.viewControllers.count; i ++) {
        UIViewController *stackController = self.navigationController.viewControllers[i];
        if ([stackController isMemberOfClass:controllerClass]) {
            if (i - 1 >= 0) {
                UIViewController *beforeController = self.navigationController.viewControllers[i - 1];
                [self.rt_navigationController popToViewController:beforeController animated:YES complete:nil];
                break;
            }
        }
    }
}
@end
