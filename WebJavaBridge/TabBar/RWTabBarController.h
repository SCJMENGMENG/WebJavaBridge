//
//  RWTabBarController.h
//  RestartProject
//
//  Created by Belly on 2019/6/24.
//  Copyright © 2019 Reworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface RWTabBarController : UITabBarController

/**
 * The tab bar view associated with this controller. (read-only)
 */
@property (nonnull, nonatomic, readonly) RWTabBar *rw_tabBar;


- (void)rw_setViewController:(NSArray<__kindof UIViewController *> * __nullable)viewControllers;

- (void)showBadgeWithSelectedIndex:(NSUInteger)selectedIndex badge:(NSString *)badgeValue;

- (void)removeBadgeWithSelectedIndex:(NSUInteger)selectedIndex;

- (BOOL)isShowBadge:(NSUInteger)selectedIndex;

@end

@interface UIViewController (RWTabBarControllerItem)

/**
 * The tab bar item that represents the view controller when added to a tab bar controller.
 */
@property(nullable, nonatomic, setter = rw_setTabBarItem:) RWTabBarItem *rw_tabBarItem;
@property(nullable, nonatomic, setter = rw_setTabBarView:) RWTabBarView *rw_tabBarView;


FOUNDATION_EXPORT NSString * _Nonnull const RWTabBarClickSelectedTabNotification;

@end

NS_ASSUME_NONNULL_END
