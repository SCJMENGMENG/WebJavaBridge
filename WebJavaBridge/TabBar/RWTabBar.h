//
//  RWTabBar.h
//  RestartProject
//
//  Created by Belly on 2019/6/24.
//  Copyright © 2019 Reworld. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RWTabBar, RWTabBarItem, RWTabBarView;

@protocol RWTabBarDelegate <NSObject>

/**
 * Asks the delegate if the specified tab bar item should be selected.
 */
- (BOOL)tabBar:(RWTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index;

/**
 * Tells the delegate that the specified tab bar item is now selected.
 */
- (void)tabBar:(RWTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;

@end

@interface RWTabBar : UIView

/**
 * The tab bar’s delegate object.
 */
@property (nonatomic, weak) id <RWTabBarDelegate> delegate;

/**
 * The items displayed on the tab bar.
 */
@property (nonatomic, copy) NSArray *items;

/**
 * The currently selected item on the tab bar.
 */
@property (nonatomic, weak) RWTabBarItem *selectedItem;

@property (nonatomic, weak) RWTabBarView *selectedView;

/**
 * backgroundView stays behind tabBar's items. If you want to add additional views,
 * add them as subviews of backgroundView.
 */
@property (nonatomic, strong) UIView *backgroundView;

/*
 * contentEdgeInsets can be used to center the items in the middle of the tabBar.
 */
@property UIEdgeInsets contentEdgeInsets;

/**
 * Sets the height of tab bar.
 */
- (void)setHeight:(CGFloat)height;

/**
 * Returns the minimum height of tab bar's items.
 */
- (CGFloat)minimumContentHeight;

/*
 * Enable or disable tabBar translucency. Default is NO.
 */
@property (nonatomic, getter=isTranslucent) BOOL translucent;

@end

NS_ASSUME_NONNULL_END
