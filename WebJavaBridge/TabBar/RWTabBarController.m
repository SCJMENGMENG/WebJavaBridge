//
//  RWTabBarController.m
//  RestartProject
//
//  Created by Belly on 2019/6/24.
//  Copyright © 2019 Reworld. All rights reserved.
//

#import "RWTabBarController.h"
#import "RWTabBarView.h"
#import <objc/runtime.h>

NSString * const RWTabBarClickSelectedTabNotification = @"tabbar.click.selectedtab.notification";

@interface RWTabBarController () <RWTabBarDelegate>

@property (nonatomic, readwrite) RWTabBar *rw_tabBar;

@end

@implementation RWTabBarController
@synthesize rw_tabBar = _rw_tabBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (@available(iOS 13, *)) {
#ifdef __IPHONE_13_0
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        appearance.backgroundImage = [UIImage new];
        appearance.shadowImage = [UIImage imageNamed:@"tabbar_top_line"];
        appearance.shadowColor = [UIColor clearColor];
        self.tabBar.standardAppearance = appearance;
#elif __IPHONE_13_1
        UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
        appearance.backgroundImage = [UIImage new];
        appearance.shadowImage = [UIImage imageNamed:@"tabbar_top_line"];
        appearance.shadowColor = [UIColor clearColor];
        self.tabBar.standardAppearance = appearance;
#endif
    } else {
        self.tabBar.backgroundImage = [UIImage new];
        self.tabBar.shadowImage = [UIImage imageNamed:@"tabbar_top_line"];
    }
    
    [self.tabBar addSubview:[self rw_tabBar]];
    
    [self.tabBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rw_tabBar setFrame:self.tabBar.bounds];
}

- (BOOL)prefersStatusBarHidden
{
    return self.selectedViewController.prefersStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return self.selectedViewController.preferredStatusBarUpdateAnimation;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.selectedViewController.preferredStatusBarStyle;
}

- (void)dealloc
{
    [self.tabBar removeObserver:self forKeyPath:@"frame"];
}

#pragma mark - NSKeyValueObserving

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(__unused id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        [self.rw_tabBar setFrame:self.tabBar.bounds];
    }
}

- (RWTabBar *)rw_tabBar
{
    if (!_rw_tabBar) {
        _rw_tabBar = [[RWTabBar alloc] init];
        [_rw_tabBar setBackgroundColor:[UIColor clearColor]];
        [_rw_tabBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                          UIViewAutoresizingFlexibleTopMargin|
                                          UIViewAutoresizingFlexibleLeftMargin|
                                          UIViewAutoresizingFlexibleRightMargin|
                                          UIViewAutoresizingFlexibleBottomMargin)];
        [_rw_tabBar setDelegate:self];
    }
    return _rw_tabBar;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
//    [[self rw_tabBar] setSelectedItem:[[self rw_tabBar] items][selectedIndex]];
    [[self rw_tabBar] setSelectedView:[[self rw_tabBar] items][selectedIndex]];
}

- (void)rw_setViewController:(NSArray<__kindof UIViewController *> * __nullable)viewControllers
{
    [self setViewControllers:viewControllers];
    
    NSUInteger count = [viewControllers count];
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
//        RWTabBarItem *tabBarItem = [[RWTabBarItem alloc] init];
//        tabBarItem.badgeTextColor = [UIColor redColor];
//        [tabBarItems addObject:tabBarItem];
        RWTabBarView *tabBarView = [[RWTabBarView alloc] init];
        [tabBarItems addObject:tabBarView];
    }
    [[self rw_tabBar] setItems:tabBarItems];
    
    [[self.tabBar items] enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setEnabled:NO];
    }];
    
    [self setSelectedIndex:0];
}

- (NSInteger)indexForViewController:(UIViewController *)viewController {
    UIViewController *searchedController = viewController;
    if ([searchedController navigationController]) {
        searchedController = [searchedController navigationController];
    }
    return [[self viewControllers] indexOfObject:searchedController];
}

- (void)showBadgeWithSelectedIndex:(NSUInteger)selectedIndex badge:(NSString *)badgeValue
{
    if (selectedIndex < [[[self rw_tabBar] items] count]) {
//        RWTabBarItem *barItem = [[self rw_tabBar] items][selectedIndex];
//        if (badgeValue) {
//            barItem.badgeValue = badgeValue;
//        }else {
//            barItem.onlyShowBadgeCircle = YES;
//        }
        RWTabBarView *barView = [[self rw_tabBar] items][selectedIndex];
//        if (badgeValue) {
//            barItem.badgeValue = badgeValue;
//        }else {
//            barItem.onlyShowBadgeCircle = YES;
//        }
    }
}

- (void)removeBadgeWithSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex < [[[self rw_tabBar] items] count]) {
//        RWTabBarItem *barItem = [[self rw_tabBar] items][selectedIndex];
//        barItem.badgeValue = nil;
//        barItem.onlyShowBadgeCircle = NO;
        RWTabBarView *barView = [[self rw_tabBar] items][selectedIndex];
//        barItem.badgeValue = nil;
//        barItem.onlyShowBadgeCircle = NO;
    }
}

- (BOOL)isShowBadge:(NSUInteger)selectedIndex
{
    if (selectedIndex < [[[self rw_tabBar] items] count]) {
//        RWTabBarItem *barItem = [[self rw_tabBar] items][selectedIndex];
//        if ([barItem.badgeValue length] ||
//            barItem.onlyShowBadgeCircle) {
//            return YES;
//        }
        
        RWTabBarView *barview = [[self rw_tabBar] items][selectedIndex];
//        if ([barItem.badgeValue length] ||
//            barItem.onlyShowBadgeCircle) {
//            return YES;
//        }
    }
    return NO;
}

#pragma mark - RDVTabBarDelegate

- (BOOL)tabBar:(RWTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index
{
    
    if ([[self delegate] respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        if (![[self delegate] tabBarController:self shouldSelectViewController:[self viewControllers][index]]) {
            return NO;
        }
    }
    
    if ([self selectedViewController] == [self viewControllers][index]) {
        if ([[self selectedViewController] isKindOfClass:[UINavigationController class]]) {
            UINavigationController *selectedController = (UINavigationController *)[self selectedViewController];
            
            if ([selectedController topViewController] != [selectedController viewControllers][0]) {
                [selectedController popToRootViewControllerAnimated:YES];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RWTabBarClickSelectedTabNotification
                                                            object:[NSString stringWithFormat:@"%zd", index]];
        
        return NO;
    }
    
    return YES;
}

- (void)tabBar:(RWTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index
{
    if (index < 0 || index >= [[self viewControllers] count]) {
        return;
    }
    
    [self setSelectedIndex:index];
    
    if ([[self delegate] respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [[self delegate] tabBarController:self didSelectViewController:[self viewControllers][index]];
    }
    
    // UIViewController not set title, should set self.navigationItem.title
    //    [self performSelector:@selector(clearTabBar) withObject:self afterDelay:0.0];
}

- (void)clearTabBar
{
    [[self.tabBar items] enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setTitle:nil];
        [obj setEnabled:NO];
    }];
}

@end

#pragma mark - UIViewController+RWTabBarControllerItem

@implementation UIViewController (RWTabBarControllerItem)

- (RWTabBarItem *)rw_tabBarItem {
    RWTabBarController *rw_tabBarController = (RWTabBarController *)self.tabBarController;
    NSInteger index = [rw_tabBarController indexForViewController:self];
    return [[[rw_tabBarController rw_tabBar] items] objectAtIndex:index];
}

- (RWTabBarView *)rw_tabBarView {
    RWTabBarController *rw_tabBarController = (RWTabBarController *)self.tabBarController;
    NSInteger index = [rw_tabBarController indexForViewController:self];
    return [[[rw_tabBarController rw_tabBar] items] objectAtIndex:index];
}

- (void)rw_setTabBarItem:(RWTabBarItem *)tabBarItem {
    if (!self.tabBarController) {
        return;
    }
    
    RWTabBarController *rw_tabBarController = (RWTabBarController *)self.tabBarController;
    RWTabBar *tabBar = [rw_tabBarController rw_tabBar];
    NSInteger index = [rw_tabBarController indexForViewController:self];
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:[tabBar items]];
    [tabBarItems replaceObjectAtIndex:index withObject:tabBarItem];
    [tabBar setItems:tabBarItems];
}

- (void)rw_setTabBarView:(RWTabBarView *)tabBarView {
    if (!self.tabBarController) {
        return;
    }
    
    RWTabBarController *rw_tabBarController = (RWTabBarController *)self.tabBarController;
    RWTabBar *tabBar = [rw_tabBarController rw_tabBar];
    NSInteger index = [rw_tabBarController indexForViewController:self];
    
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:[tabBar items]];
    [tabBarItems replaceObjectAtIndex:index withObject:tabBarView];
    [tabBar setItems:tabBarItems];
}

@end
