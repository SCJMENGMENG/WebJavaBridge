//
//  UIViewController+TopMost.h
//  NewsEarn
//
//  Created by zhubch on 2018/7/11.
//  Copyright © 2018年 CooHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(TopMost)

@property(class,readonly) UIViewController *topMost;

@property(class,readonly) UITabBarController *rootTabBarController;

- (void)popToControllerClass:(Class)controllerClass;

- (void)popToControllerBeforeClass:(Class)controllerClass;
@end
