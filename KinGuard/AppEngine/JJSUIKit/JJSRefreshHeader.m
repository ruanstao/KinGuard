//
//  JJSRefreshHeader.m
//  JJSOA
//
//  Created by RuanSTao on 16/1/27.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSRefreshHeader.h"
#import "JJSActivityIndicatorView.h"
@interface JJSRefreshHeader()<JJSActivityIndicatorViewDelegate>

@property (weak, nonatomic) JJSActivityIndicatorView *indicatorView;

@end

@implementation JJSRefreshHeader

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 45;
    
    // 添加label
    JJSActivityIndicatorView *indicatorView = [[JJSActivityIndicatorView alloc] init];
    indicatorView.delegate = self;
    indicatorView.numberOfCircles = 4;
    indicatorView.radius = 10;
    indicatorView.internalSpacing = 4;
    [indicatorView prepareAnimation];
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
//    self.indicatorView.frame = self.bounds;
    self.indicatorView.center =  CGPointMake(self.mj_w *0.5 - 45 , self.mj_h * 0.5 - 5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.indicatorView stopAnimating];
            break;
        case MJRefreshStatePulling:
            //            [self.loading stopAnimating];
            //            [self.s setOn:YES animated:YES];
            //            self.label.text = @"赶紧放开我吧(开关是打酱油滴)";
            [self.indicatorView prepareAnimation];
            break;
        case MJRefreshStateRefreshing:
            //            [self.s setOn:YES animated:YES];
            //            //            self.label.text = @"加载数据中(开关是打酱油滴)";
            //            [self.loading startAnimating];
            [self.indicatorView startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
//    CGFloat red = 1.0 - pullingPercent * 0.5;
//    CGFloat green = 0.5 - 0.5 * pullingPercent;
//    CGFloat blue = 0.5 * pullingPercent;
    //    self.label.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark -
#pragma mark - JJSActivityIndicatorViewDelegate Methods

- (UIColor *)activityIndicatorView:(JJSActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index {
    NSArray *colors = @[RGB(3, 85, 210),
                        RGB(3, 104, 222),
                        RGB(58, 184, 161),
                        RGB(255, 127, 45)];

    return [colors objectAtIndex:index % colors.count];
}

@end
