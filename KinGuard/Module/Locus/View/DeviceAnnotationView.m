//
//  DeviceAnnotationView.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "DeviceAnnotationView.h"
#import "CircleView.h"

#define kWidth  20.f
#define kHeight 20.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   260.0
#define kCalloutHeight  60.0

@implementation DeviceAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
//             Construct custom callout. 
            self.calloutView = [DeviceInfoView creatByNib];
            self.calloutView.frame = CGRectMake(0, 0, kCalloutWidth, kCalloutHeight);
            
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            [self.calloutView initWithLocationModel:self.locationInfo];

        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
        
        self.backgroundColor = [UIColor clearColor];
        CircleView *circle = [[CircleView alloc] initWithFrame:self.bounds];
//        circle.frame = rect;
        circle.borderColor = HexRGB(0x4A90E2);
        circle.borderWidth = 1;
        circle.holeColor = HexRGB(0x4A90E2);
        circle.isSelected = YES;
        circle.isAnimationEnabled = YES;
        __weak typeof(self) weakSelf = self;
        circle.circleClickBlock = ^(CircleView *circleView){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf setSelected:!self.selected animated:YES];
        };
        [self addSubview:circle];
        
    }
    
    return self;
}

@end
