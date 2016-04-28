//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Awesome)

@property (nonatomic,strong) UIView * leftBarButton;
@property (nonatomic,strong) UIView * leftSecBarButton;
@property (nonatomic,strong) UIView * rightBarButton;
@property (nonatomic,strong) UIView * rightSecBarButton;
@property (nonatomic,assign) CGFloat backgroundColorAlpha;
@property (nonatomic,strong) UIView * titleView;
@property (nonatomic,strong) UIView * titleSecView;

- (void)lt_setBackgroundColor:(UIColor *) backgroundColor andAlpha:(CGFloat) alpha;
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setContentAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end
