//
//  RWTabBar.m
//  RestartProject
//
//  Created by Belly on 2019/6/24.
//  Copyright © 2019 Reworld. All rights reserved.
//

#import "RWTabBar.h"
#import "RWTabBarView.h"

#import "Header.h"

@interface RWTabBar ()

@property (nonatomic) CGFloat itemWidth;

@end

@implementation RWTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitialization];
    }
    return self;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitialization {
    _backgroundView = [[UIView alloc] init];
    [self addSubview:_backgroundView];
    
    [self setTranslucent:NO];
    
    _backgroundView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    CGSize frameSize = self.frame.size;
    CGFloat minimumContentHeight = [self minimumContentHeight];
    
    [[self backgroundView] setFrame:CGRectMake(0, frameSize.height - minimumContentHeight,
                                               frameSize.width, frameSize.height)];
    
    [self setItemWidth:roundf((frameSize.width - [self contentEdgeInsets].left -
                               [self contentEdgeInsets].right) / [[self items] count])];
    
    NSInteger index = 0;
    
    // Layout items
    
    for (RWTabBarView *item in [self items]) {
        CGFloat itemHeight = [item itemHeight];
        
        if (!itemHeight) {
            itemHeight = frameSize.height;
            if (isIPhoneX()) {
                itemHeight -= 34;
            }
        }
        
        if (isIPhoneX()) {
            [item setFrame:CGRectMake(self.contentEdgeInsets.left + (index * self.itemWidth),
                                      roundf(frameSize.height - itemHeight - 34) - self.contentEdgeInsets.top,
                                      self.itemWidth, itemHeight - self.contentEdgeInsets.bottom)];
        }else{
            [item setFrame:CGRectMake(self.contentEdgeInsets.left + (index * self.itemWidth),
                                      roundf(frameSize.height - itemHeight) - self.contentEdgeInsets.top,
                                      self.itemWidth, itemHeight - self.contentEdgeInsets.bottom)];
            
        }
        
        [item setNeedsDisplay];
        
        index++;
    }
    
//    for (RWTabBarItem *item in [self items]) {
//        CGFloat itemHeight = [item itemHeight];
//
//        if (!itemHeight) {
//            itemHeight = frameSize.height;
//            if (isIPhoneX()) {
//                itemHeight -= 34;
//            }
//        }
//
//        if (isIPhoneX()) {
//            [item setFrame:CGRectMake(self.contentEdgeInsets.left + (index * self.itemWidth),
//                                      roundf(frameSize.height - itemHeight - 34) - self.contentEdgeInsets.top,
//                                      self.itemWidth, itemHeight - self.contentEdgeInsets.bottom)];
//        }else{
//            [item setFrame:CGRectMake(self.contentEdgeInsets.left + (index * self.itemWidth),
//                                      roundf(frameSize.height - itemHeight) - self.contentEdgeInsets.top,
//                                      self.itemWidth, itemHeight - self.contentEdgeInsets.bottom)];
//
//        }
//
//        [item setNeedsDisplay];
//
//        index++;
//    }
}

#pragma mark - Configuration

- (void)setItemWidth:(CGFloat)itemWidth {
    if (itemWidth > 0) {
        _itemWidth = itemWidth;
    }
}

- (void)setItems:(NSArray *)items {
    for (RWTabBarView *item in _items) {
        [item removeFromSuperview];
    }
    
    _items = [items copy];
    for (RWTabBarView *item in _items) {
//        [item addTarget:self action:@selector(tabBarItemWasSelected:) forControlEvents:UIControlEventTouchDown];
        [item.tabbarBtn addTarget:self action:@selector(tabBarItemWasSelected:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:item];
    }
    
//    for (RWTabBarItem *item in _items) {
//        [item removeFromSuperview];
//    }
//
//    _items = [items copy];
//    for (RWTabBarItem *item in _items) {
//        [item addTarget:self action:@selector(tabBarItemWasSelected:) forControlEvents:UIControlEventTouchDown];
//        [self addSubview:item];
//    }
}

- (void)setHeight:(CGFloat)height {
    [self setFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame), height)];
}

- (CGFloat)minimumContentHeight {
    CGFloat minimumTabBarContentHeight = CGRectGetHeight([self frame]);
    
    for (RWTabBarView *item in [self items]) {
        CGFloat itemHeight = [item itemHeight];
        if (itemHeight && (itemHeight < minimumTabBarContentHeight)) {
            minimumTabBarContentHeight = itemHeight;
        }
    }
    
//    for (RWTabBarItem *item in [self items]) {
//        CGFloat itemHeight = [item itemHeight];
//        if (itemHeight && (itemHeight < minimumTabBarContentHeight)) {
//            minimumTabBarContentHeight = itemHeight;
//        }
//    }
    
    return minimumTabBarContentHeight;
}

#pragma mark - Item selection

- (void)tabBarItemWasSelected:(id)sender {
    UIButton *btn = (UIButton *)sender;
    RWTabBarView *AView = (RWTabBarView *)btn.superview;
    
    AView.isSelected = YES;
    
    [self setSelectedView:AView];
    [AView setNeedsDisplay];

    NSInteger index = [self.items indexOfObject:AView];
    
    if ([[self delegate] respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
        if (![[self delegate] tabBar:self shouldSelectItemAtIndex:index]) {
            return;
        }
    }
    
    if ([[self delegate] respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
        [[self delegate] tabBar:self didSelectItemAtIndex:index];
    }
    
    for (int i = 0; i< self.items.count; i++) {
        if (i != index) {
            RWTabBarView *tabV = (RWTabBarView *)self.items[i];
            tabV.isSelected = NO;
            [tabV setNeedsDisplay];
        }
    }
}

- (void)setSelectedView:(RWTabBarView *)selectedView {
    if (selectedView == _selectedView) {
        return;
    }
    _selectedView.isSelected = NO;

    _selectedView = selectedView;
    _selectedView.isSelected = YES;
//    [_selectedView setNeedsDisplay];
}

//- (void)setSelectedItem:(RWTabBarItem *)selectedItem {
//    if (selectedItem == _selectedItem) {
//        return;
//    }
//    [_selectedItem setSelected:NO];
//
//    _selectedItem = selectedItem;
//    [_selectedItem setSelected:YES];
//}

#pragma mark - Translucency

- (void)setTranslucent:(BOOL)translucent {
    _translucent = translucent;
    
    CGFloat alpha = (translucent ? 0.9 : 1.0);
    
    [_backgroundView setBackgroundColor:[UIColor colorWithRed:245/255.0
                                                        green:245/255.0
                                                         blue:245/255.0
                                                        alpha:alpha]];
}

@end
