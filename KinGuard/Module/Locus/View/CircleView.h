//
//  CircleView.h
//  Charts
//
//  Created by RuanSTao on 15/7/15.
//  Copyright (c) 2015年 JJS-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CircleClickBlock)(id);
@interface CircleView : UIButton

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *holeColor;
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) BOOL isAnimationEnabled;

@property (nonatomic, strong) CircleClickBlock circleClickBlock;
@end
