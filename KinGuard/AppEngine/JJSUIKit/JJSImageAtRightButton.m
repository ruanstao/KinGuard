//
//  JJSImageAtRightButton.m
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/15.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSImageAtRightButton.h"

//#define titleRatio (0.8)

#define  TextAttribute(textAttrs, font) do{\
textAttrs[NSFontAttributeName] = font;\
}while(0)

@implementation JJSImageAtRightButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //高亮时不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.frame.size.width * self.titleRatio == 0 ? 0.8 : self.titleRatio;
    CGFloat imageH = self.frame.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width * self.titleRatio == 0 ? 0.8 : self.titleRatio;
    CGFloat titleH = self.frame.size.height;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    TextAttribute(textAttrs, self.titleLabel.font);
    CGSize titleSize = [title sizeWithAttributes:textAttrs];
    CGRect frame = self.frame;
    frame.size.width = titleSize.width + 30;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}


@end
