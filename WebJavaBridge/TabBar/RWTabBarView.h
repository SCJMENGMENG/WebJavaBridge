//
//  RWTabBarView.h
//  RestartProject
//
//  Created by scj on 2019/12/26.
//  Copyright © 2019 Reworld. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Lottie/Lottie.h>

NS_ASSUME_NONNULL_BEGIN

@interface RWTabBarView : UIView

@property CGFloat itemHeight;

@property (nonatomic) UIOffset titlePositionAdjustment;
@property (nonatomic) UIOffset imagePositionAdjustment;

@property (copy) NSDictionary *unselectedTitleAttributes;
@property (copy) NSDictionary *selectedTitleAttributes;

@property (nonatomic, weak) LOTAnimationView *tabBarTottieImg;
@property (nonatomic, copy) NSString *tabBarTitle;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) CGSize imgSizeaa;

@property (nonatomic, strong) UIButton *tabbarBtn;

- (void)setTottieImg:(LOTAnimationView *)lottieimg;

@end

NS_ASSUME_NONNULL_END
