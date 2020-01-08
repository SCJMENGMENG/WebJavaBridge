//
//  RWTabBarView.m
//  RestartProject
//
//  Created by scj on 2019/12/26.
//  Copyright © 2019 Reworld. All rights reserved.
//

#import "RWTabBarView.h"

#import <Masonry.h>

@interface RWTabBarView () {
    NSString *_tabBarTitle;
    UIOffset _imagePositionAdjustment;
    NSDictionary *_unselectedTitleAttributes;
    NSDictionary *_selectedTitleAttributes;
}

@end

@implementation RWTabBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self commonInitialization];
    }
    return self;
}

- (void)commonInitialization {
    [self setBackgroundColor:[UIColor clearColor]];
    
    _tabBarTitle = @"";
    _titlePositionAdjustment = UIOffsetZero;
    
    _unselectedTitleAttributes = @{
                                   NSFontAttributeName: [UIFont systemFontOfSize:12],
                                   NSForegroundColorAttributeName: [UIColor blackColor],
                                   };
    
    _selectedTitleAttributes = [_unselectedTitleAttributes copy];
    
    self.tabbarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.tabbarBtn];
    [self.tabbarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)drawRect:(CGRect)rect {
    CGSize frameSize = self.frame.size;
    CGSize imageSize = CGSizeZero;
    CGSize titleSize = CGSizeZero;
    CGFloat imageStartingY = 0.0f;
    NSDictionary *titleAttributes = nil;
    
    LOTAnimationView *lottieImg = [self tabBarTottieImg];
    
    imageSize = self.imgSizeaa;
    
    if ([self isSelected]) {
        [self.tabBarTottieImg play];
        titleAttributes = [self selectedTitleAttributes];
        if (!titleAttributes) {
            titleAttributes = [self unselectedTitleAttributes];
        }
    }
    else {
        [self.tabBarTottieImg stop];
        titleAttributes = [self unselectedTitleAttributes];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (![_tabBarTitle length]) {
        
    } else {
        
        titleSize = [_tabBarTitle boundingRectWithSize:CGSizeMake(frameSize.width, 20)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:titleAttributes
                                         context:nil].size;
        
        lottieImg.frame = CGRectMake(roundf(frameSize.width / 2 - imageSize.width / 2) +
        _imagePositionAdjustment.horizontal,
        imageStartingY + _imagePositionAdjustment.vertical,
                                     imageSize.width, imageSize.height);
        
        [_tabBarTitle drawInRect:CGRectMake(roundf(frameSize.width / 2 - titleSize.width / 2) +
                                      _titlePositionAdjustment.horizontal,
                                      imageStartingY + imageSize.height + _titlePositionAdjustment.vertical,
                                      titleSize.width, titleSize.height)
            withAttributes:titleAttributes];
    }
}

- (void)setTabBarTottieImg:(LOTAnimationView *)tabBarTottieImg {
    _tabBarTottieImg = tabBarTottieImg;
}

- (void)setTottieImg:(LOTAnimationView *)lottieimg {
    self.tabBarTottieImg = lottieimg;
    if (lottieimg) {
        [self addSubview:lottieimg];
        [self bringSubviewToFront:self.tabbarBtn];
    }
}

@end
