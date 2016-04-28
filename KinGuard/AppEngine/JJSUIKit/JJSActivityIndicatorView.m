//
//  JJSActivityIndicatorView.m
//  JJSOA
//
//  Created by RuanSTao on 16/1/27.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationType_Stop = 1,
    AnimationType_Prepare,
    AnimationType_Start,
};

#import "JJSActivityIndicatorView.h"

@interface JJSActivityIndicatorView ()

/** The default color of each circle. */
@property (strong, nonatomic) UIColor *defaultColor;

/** An indicator whether the activity indicator view is animating. */
@property (readwrite, nonatomic) BOOL isAnimating;

/**
 Sets up default values
 */
- (void)setupDefaults;

/**
 Adds circles.
 */
- (void)addCirclesWithType:(AnimationType)type;

/**
 Removes circles.
 */
- (void)removeCircles;

/**
 Creates the circle view.
 @param radius The radius of the circle.
 @param color The background color of the circle.
 @param positionX The x-position of the circle in the contentView.
 @return The circle view.
 */
- (UIView *)createCircleWithRadius:(CGFloat)radius color:(UIColor *)color positionX:(CGFloat)x;

/**
 Creates the animation of the circle.
 @param duration The duration of the animation.
 @param delay The delay of the animation
 @return The animation of the circle.
 */
- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay;

@end

@implementation JJSActivityIndicatorView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark -
#pragma mark - Initializations

- (id)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

#pragma mark -
#pragma mark - Intrinsic Content Size

- (CGSize)intrinsicContentSize {
    CGFloat width = (self.numberOfCircles * ((2 * self.radius) + self.internalSpacing)) - self.internalSpacing;
    CGFloat height = self.radius * 2;
    return CGSizeMake(width, height);
}

#pragma mark -
#pragma mark - Private Methods

- (void)setupDefaults {
    //    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberOfCircles = 5;
    self.internalSpacing = 5;
    self.radius = 10;
    self.delay = 0.2;
    self.duration = 0.8;
    self.defaultColor = [UIColor lightGrayColor];
}

- (UIView *)createCircleWithRadius:(CGFloat)radius
                             color:(UIColor *)color
                         positionX:(CGFloat)x {
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(x, 0, radius * 2, radius * 2)];
    circle.backgroundColor = color;
    circle.layer.cornerRadius = radius;
    circle.translatesAutoresizingMaskIntoConstraints = NO;
    return circle;
}

- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.delegate = self;
    anim.fromValue = [NSNumber numberWithFloat:0.6f];
    anim.toValue = [NSNumber numberWithFloat:1.0f];
    anim.autoreverses = YES;
    anim.duration = duration;
    anim.removedOnCompletion = NO;
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.repeatCount = INFINITY;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return anim;
}

- (void)addCirclesWithType:(AnimationType)type
{
    for (NSUInteger i = 0; i < self.numberOfCircles; i++) {
        UIColor *color = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(activityIndicatorView:circleBackgroundColorAtIndex:)]) {
            color = [self.delegate activityIndicatorView:self circleBackgroundColorAtIndex:i];
        }
        UIView *circle = [self createCircleWithRadius:self.radius
                                                color:(color == nil) ? self.defaultColor : color
                                            positionX:(i * ((2 * self.radius) + self.internalSpacing))];
        switch (type) {
            case AnimationType_Stop:{
                [circle setTransform:CGAffineTransformMakeScale(0.6, 0.6)];
            }
                break;
            case AnimationType_Prepare:{
                [circle setTransform:CGAffineTransformMakeScale(0.6, 0.6)];
                if (i == 0 || i +1 ==self.numberOfCircles) {
                    [circle.layer addAnimation:[self createAnimationWithDuration:self.duration delay:(i * self.delay)] forKey:@"scale"];
                }
            }
                break;
            case AnimationType_Start:{
                [circle setTransform:CGAffineTransformMakeScale(0.6, 0.6)];
                [circle.layer addAnimation:[self createAnimationWithDuration:self.duration delay:(i * self.delay)] forKey:@"scale"];
            }
                break;
            default:
                break;
        }
        [self addSubview:circle];
    }
}

- (void)removeCircles {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark - Public Methods

- (void)startAnimating {
    if (!self.isAnimating) {
        [self removeCircles];
        [self addCirclesWithType:AnimationType_Start];
        self.hidden = NO;
        self.isAnimating = YES;
    }
}

- (void)stopAnimating {
    //    if (self.isAnimating) {
    [self removeCircles];
    [self addCirclesWithType:AnimationType_Stop];
    //        self.hidden = YES;
    self.isAnimating = NO;
    //}
}

- (void)prepareAnimation
{
    [self removeCircles];
    [self addCirclesWithType:AnimationType_Prepare];
    self.isAnimating = NO;
}

#pragma mark -
#pragma mark - Custom Setters and Getters

- (void)setNumberOfCircles:(NSUInteger)numberOfCircles {
    _numberOfCircles = numberOfCircles;
    [self invalidateIntrinsicContentSize];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self invalidateIntrinsicContentSize];
}

- (void)setInternalSpacing:(CGFloat)internalSpacing {
    _internalSpacing = internalSpacing;
    [self invalidateIntrinsicContentSize];
}

@end
