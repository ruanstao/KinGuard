//
//  CircleView.m
//  Charts
//
//  Created by RuanSTao on 15/7/15.
//  Copyright (c) 2015年 JJS-iMac. All rights reserved.
//

#import "CircleView.h"

@interface CircleView ()
{
    BOOL _double ;
    CAShapeLayer *_circleLayer;
    CAShapeLayer *_outSideCircleLayer;
}
@property (nonatomic, strong) UIView *highLightView;

@end

@implementation CircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        _double = YES;
    }else{
        _double = NO;
    }
    [self setNeedsDisplay];
}

-(void) beginAnimation
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _double = NO;
//        [self updateMaskToBounds:CGRectMake(CGRectGetMinX(frame) +  CGRectGetWidth(frame) / 4.0, CGRectGetMinY(frame) +  CGRectGetHeight(frame) / 4.0, CGRectGetWidth(frame) / 2.0, CGRectGetHeight(frame) / 2.0)];
    }
    return self;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _double = NO;
//    }
//    return self;
//}



-(void)drawRect:(CGRect)rect
{
    
    [self drawCircle:rect doubleCircle:_double];
    if (self.isAnimationEnabled) {
        [self drawOutSideCircle:rect touchAnimateOpen:self.isSelected];
    }
}

-(void)layoutSubviews
{
    
}

-(void) drawCircle:(CGRect)rect doubleCircle:(BOOL)b
{
//    if (_circleLayer) {
//        [_circleLayer removeFromSuperlayer];
//        _circleLayer = nil;
//    }
    if (_circleLayer == nil) {
        _circleLayer = [[CAShapeLayer alloc] init];

        
        _circleLayer.strokeColor = self.borderColor.CGColor;
        _circleLayer.lineWidth = self.borderWidth;
       
        _circleLayer.cornerRadius = CGRectGetHeight(rect) / 2.0;
        
        [self.layer addSublayer:_circleLayer];
    }
    CGRect insideCircleRect = CGRectMake(CGRectGetMinX(rect) +  CGRectGetWidth(rect) / 4.0, CGRectGetMinY(rect) +  CGRectGetHeight(rect) / 4.0, CGRectGetWidth(rect) / 2.0, CGRectGetHeight(rect) / 2.0);
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    _circleLayer.fillColor = [self.borderColor colorWithAlphaComponent:0.8].CGColor;//[UIColor whiteColor].CGColor;
    if ((!self.isAnimationEnabled) && b) {
        [path addArcWithCenter:centerPoint radius: CGRectGetHeight(rect) / 2.0 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        _circleLayer.fillColor = [self.holeColor colorWithAlphaComponent:0.4].CGColor;
        
    }
    [path moveToPoint:CGPointMake(centerPoint.x + CGRectGetWidth(rect) / 4,centerPoint.y )];
    [path addArcWithCenter:centerPoint radius:CGRectGetHeight(insideCircleRect) / 2.0  startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    _circleLayer.bounds = rect;
    _circleLayer.path = path.CGPath;
     _circleLayer.position = centerPoint;

}

- (void)updateMaskToBounds:(CGRect)maskBounds {
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    CGPathRef maskPath = CGPathCreateWithEllipseInRect(maskBounds, NULL);
    
    maskLayer.bounds = maskBounds;
    maskLayer.path = maskPath;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;
    
    CGPoint point = CGPointMake(CGRectGetWidth(maskBounds), CGRectGetHeight(maskBounds));;
    maskLayer.position = point;
    [self.layer addSublayer:maskLayer];
//    [self.layer setMask:maskLayer];
    
//    self.layer.cornerRadius = CGRectGetHeight(maskBounds) / 2.0;
//    self.layer.borderColor = [self.borderColor colorWithAlphaComponent:0.7].CGColor;
//    self.layer.borderWidth = self.borderWidth;
    
//    self.highLightView.frame = self.bounds;
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
//    NSLog(@"beginTrackTouch");
    if (self.circleClickBlock) {
        self.circleClickBlock(self);
    }
    return YES;
}

- (void)drawOutSideCircle:(CGRect)rect touchAnimateOpen:(BOOL)open
{
    if (_outSideCircleLayer == nil) {
        _outSideCircleLayer = [[CAShapeLayer alloc] init];
        _outSideCircleLayer.cornerRadius = CGRectGetHeight(rect) / 2;
        _outSideCircleLayer.position =  CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect));
        _outSideCircleLayer.fillColor = [self.holeColor colorWithAlphaComponent:0.4].CGColor;
//        _outSideCircleLayer.opacity = 1;
        _outSideCircleLayer.strokeColor = self.borderColor.CGColor;
        _outSideCircleLayer.lineWidth = self.borderWidth / 2.0;
        

        CGRect insideCircleRect = CGRectMake(0, 0, CGRectGetWidth(rect) / 2.0, CGRectGetHeight(rect) / 2.0);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointZero radius:CGRectGetHeight(insideCircleRect) / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        _outSideCircleLayer.path = path.CGPath;
        _outSideCircleLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _outSideCircleLayer.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:_outSideCircleLayer];
    }
    
    NSString *animationKey = @"key";
    [_outSideCircleLayer removeAnimationForKey:animationKey];
    if (open) {
       CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.keyTimes = @[@0,@0.618,@1];
        scaleAnimation.values =@[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5,2.5, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0,2.0,1)]];
        scaleAnimation.duration = 2.0f;
//        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        scaleAnimation.repeatCount = MAXFLOAT;
        
        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        alphaAnimation.fromValue = @1;
        alphaAnimation.toValue = @0;

        CAAnimationGroup *animation = [CAAnimationGroup animation];
        animation.animations = @[scaleAnimation, alphaAnimation];
        animation.duration = 2.0f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        animation.repeatCount = MAXFLOAT;
        [_outSideCircleLayer addAnimation:animation forKey:animationKey];
    }else{
//        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
//        scaleAnimation.keyTimes = @[@0,@0.618,@1];
//        scaleAnimation.values =@[[NSValue valueWithCATransform3D:CATransform3DIdentity],
//                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.8,1.8, 1)],
//                                 [NSValue valueWithCATransform3D:CATransform3DIdentity]];
//        scaleAnimation.duration = 2;
//        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        [_outSideCircleLayer addAnimation:scaleAnimation forKey:animationKey];
//        
    }
//        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//        scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
//    
//        CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//        alphaAnimation.fromValue = @1;
//        alphaAnimation.toValue = @0;
//    
//        CAAnimationGroup *animation = [CAAnimationGroup animation];
//        animation.animations = @[scaleAnimation, alphaAnimation];
//        animation.duration = 0.5f;
//        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//        [circleShape addAnimation:animation forKey:nil];
}

//- (void)blinkAnimate
//{
//    self.highLightView.alpha = 1;
//    
//    __weak typeof(self) this = self;
//    
//    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        
//        this.highLightView.alpha = 0.0;
//        
//    } completion:^(BOOL finished) {
//        
//    }];
//    
//    CGRect pathFrame = CGRectMake(-CGRectGetMidX(self.bounds), -CGRectGetMidY(self.bounds), self.bounds.size.width, self.bounds.size.height);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:self.layer.cornerRadius];
//    
//    // accounts for left/right offset and contentOffset of scroll view
//    CGPoint shapePosition = [self.superview convertPoint:self.center fromView:self.superview];
//    
//    CAShapeLayer *circleShape = [CAShapeLayer layer];
//    circleShape.path = path.CGPath;
//    circleShape.position = shapePosition;
//    circleShape.fillColor = [UIColor clearColor].CGColor;
//    circleShape.opacity = 0;
//    circleShape.strokeColor = self.borderColor.CGColor;
//    circleShape.lineWidth = 2.0;
//    
//    [self.superview.layer addSublayer:circleShape];
//    
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.5, 2.5, 1)];
//    
//    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    alphaAnimation.fromValue = @1;
//    alphaAnimation.toValue = @0;
//    
//    CAAnimationGroup *animation = [CAAnimationGroup animation];
//    animation.animations = @[scaleAnimation, alphaAnimation];
//    animation.duration = 0.5f;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    [circleShape addAnimation:animation forKey:nil];
//
//}


@end

