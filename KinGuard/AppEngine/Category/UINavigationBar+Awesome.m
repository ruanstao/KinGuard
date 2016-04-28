//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Awesome)
static char overlayKey;
static char emptyImageKey;
#define leftBarBtn @"leftBarBtn"
#define leftSecBarBtn @"leftSecBarBtn"
#define rightBarBtn @"rightBarButton"
#define rightSecBarBtn @"rightSecBarButton"
#define BackgroundColorAlpha @"BackgroundColorAlpha"
#define TitleView @"TitleView"
#define TitleSecView @"TitleSecView"

- (void) setTitleView:(UIView *)titleView
{
    [self addSubview:titleView];
    objc_setAssociatedObject(self, TitleView, titleView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *) titleView
{
    return objc_getAssociatedObject(self, TitleView);
}

- (void) setTitleSecView:(UIView *)titleSecView
{
    [self addSubview:titleSecView];
    objc_setAssociatedObject(self, TitleSecView, titleSecView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *) titleSecView
{
    return objc_getAssociatedObject(self, TitleSecView);
}

- (void) setLeftBarButton:(UIView *)leftBarButton
{
    //    leftBarButton.alpha = self.backgroundColorAlpha;
    [self addSubview:leftBarButton];
    objc_setAssociatedObject(self, leftBarBtn, leftBarButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIView *) leftBarButton
{
    return objc_getAssociatedObject(self, leftBarBtn);
}

- (void) setRightBarButton:(UIView *)rightBarButton
{
    //    rightBarButton.alpha = self.backgroundColorAlpha;
    [self addSubview:rightBarButton];
    objc_setAssociatedObject(self, rightBarBtn, rightBarButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *) rightBarButton
{
    return objc_getAssociatedObject(self, rightBarBtn);
}

-(void) setLeftSecBarButton:(UIView *)leftSecBarButton
{
    //    leftSecBarButton.alpha = self.backgroundColorAlpha;
    [self addSubview:leftSecBarButton];
    objc_setAssociatedObject(self, leftSecBarBtn, leftSecBarButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *) leftSecBarButton
{
    return objc_getAssociatedObject(self, leftSecBarBtn);
}

- (void) setRightSecBarButton:(UIView *)rightSecBarButton
{
    //    rightSecBarButton.alpha = 1 - self.backgroundColorAlpha;
    [self addSubview:rightSecBarButton];
    objc_setAssociatedObject(self, rightSecBarBtn, rightSecBarButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *) rightSecBarButton
{
    return objc_getAssociatedObject(self, rightSecBarBtn);
}

- (void) setBackgroundColorAlpha:(CGFloat)backgroundColorAlpha
{
    NSNumber * num = [NSNumber numberWithFloat:backgroundColorAlpha];
    objc_setAssociatedObject(self, BackgroundColorAlpha, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CGFloat)backgroundColorAlpha
{
    NSNumber * num = (NSNumber *) objc_getAssociatedObject(self, BackgroundColorAlpha);
    return [num floatValue];
}

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)emptyImage
{
    return objc_getAssociatedObject(self, &emptyImageKey);
}

- (void)setEmptyImage:(UIImage *)image
{
    objc_setAssociatedObject(self, &emptyImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *) backgroundColor andAlpha:(CGFloat) alpha
{
    self.backgroundColorAlpha = alpha;
    self.leftBarButton.alpha = alpha;
    self.leftSecBarButton.alpha = 1-alpha;
    self.rightBarButton.alpha = alpha;
    self.rightSecBarButton.alpha = 1 - alpha;
    self.titleView.alpha = alpha;
    self.titleSecView.alpha = 1 - alpha;
    [self lt_setBackgroundColor:[backgroundColor colorWithAlphaComponent:alpha]];
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lt_setContentAlpha:(CGFloat)alpha
{
    if (!self.overlay) {
        [self lt_setBackgroundColor:self.barTintColor];
    }
    [self setAlpha:alpha forSubviewsOfView:self];
    if (alpha == 1) {
        if (!self.emptyImage) {
            self.emptyImage = [UIImage new];
        }
        self.backIndicatorImage = self.emptyImage;
    }
}

- (void)setAlpha:(CGFloat)alpha forSubviewsOfView:(UIView *)view
{
    for (UIView *subview in view.subviews) {
        if (subview == self.overlay) {
            continue;
        }
        subview.alpha = alpha;
        [self setAlpha:alpha forSubviewsOfView:subview];
    }
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
