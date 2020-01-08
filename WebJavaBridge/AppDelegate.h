//
//  AppDelegate.h
//  WebJavaBridge
//
//  Created by scj on 2019/12/24.
//  Copyright © 2019 scj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RWTabBarController.h"
#import "RTRootNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

@property (nonatomic, strong) RWTabBarController *tabbarController;
@property (nonatomic, strong) RTRootNavigationController *rootNavigationController;
@end

