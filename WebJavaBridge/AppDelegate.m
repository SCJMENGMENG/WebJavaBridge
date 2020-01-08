//
//  AppDelegate.m
//  WebJavaBridge
//
//  Created by scj on 2019/12/24.
//  Copyright © 2019 scj. All rights reserved.
//

#import "AppDelegate.h"
#import "RWTabBar.h"
#import "RWTabBarView.h"

#import "MineViewController.h"
#import "HomeViewController.h"

#import <Lottie/Lottie.h>

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self setupRootViewControllers];
    [self.window setRootViewController:self.rootNavigationController];
    [self.window makeKeyAndVisible];
    
    [self initAppConfig];
    
    return YES;
}

- (void)setupRootViewControllers {
    HomeViewController *homeVC = [HomeViewController new];
    RTContainerNavigationController *homeVCNav = [[RTContainerNavigationController alloc] initWithRootViewController:homeVC];
    
    MineViewController *mineVC = [MineViewController new];
    RTContainerNavigationController *mineVCNav = [[RTContainerNavigationController alloc] initWithRootViewController:mineVC];
    
    NSArray *viewControllers = @[homeVCNav,mineVCNav];
    
    RWTabBarController *tabBarC = [[RWTabBarController alloc] init];
    [tabBarC rw_setViewController:viewControllers];
    tabBarC.delegate = self;
    self.tabbarController = tabBarC;
    
    self.rootNavigationController = [[RTRootNavigationController alloc] initWithRootViewControllerNoWrapping:self.tabbarController];
    [self.rootNavigationController setNavigationBarHidden:YES];
    [self customizeTabBarForController:tabBarC];
}

- (void)customizeTabBarForController:(RWTabBarController *)tabBarController {
    
    RWTabBar *tabBar = [tabBarController rw_tabBar];
    [[tabBar items] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RWTabBarView *itemV = (RWTabBarView *)obj;
        NSString *tabBarTitle;
        LOTAnimationView *lottieImg;
        lottieImg.userInteractionEnabled = YES;
        switch (idx) {
            case 0:
            {
                itemV.imgSizeaa = CGSizeMake(29, 28);
                tabBarTitle = @"首页";
                lottieImg = [LOTAnimationView animationNamed:@"home"];
            }
                break;
            case 1:
            {
                itemV.imgSizeaa = CGSizeMake(29, 28);
                tabBarTitle = @"我的";
                lottieImg = [LOTAnimationView animationNamed:@"person"];
            }
                break;
            default:
                break;
        }
        
        [itemV setTabBarTitle:tabBarTitle];
        [itemV setTottieImg:lottieImg];
        
        itemV.unselectedTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
        itemV.selectedTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]};
        itemV.titlePositionAdjustment = UIOffsetMake(0, 2);
    }];
}

- (void)initAppConfig {
    NSHTTPCookieStorage *sharedHTTPCookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    if ([sharedHTTPCookieStorage cookieAcceptPolicy] != NSHTTPCookieAcceptPolicyAlways) {
        [sharedHTTPCookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    }
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
}

@end
