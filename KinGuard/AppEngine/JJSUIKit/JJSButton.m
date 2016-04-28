//
//  JJSButton.m
//  JJSOA
//
//  Created by Koson on 15-2-12.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSButton.h"

@implementation JJSButton

@synthesize imageViewRect,titleViewRect;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetRGBFillColor (context, 0.933, 0.388, 0.224, 1.0);
//    CGContextFillEllipseInRect(context, self.imageViewRect);
//
//    UIImage *image = [JJSUtil imageWithColor:[UIColor colorWithRed:0.933 green:0.388 blue:0.224 alpha:1]];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 120, 54, 54)];
//    [imageView setImage:image];
//    imageView.layer.cornerRadius = 54/2.0;
//    imageView.layer.masksToBounds = YES;
//    [self addSubview:imageView];
//
//}

#pragma mark -
#pragma mark setting image bounds for button
/**
 *  Image rect
 *
 *  @param contentRect content rect
 *
 *  @return image rect
 *
 *  @since 1.0.0
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    //    CGFloat width = contentRect.size.width;
    //    CGFloat height = contentRect.size.height * 0.7;
    //    return CGRectMake(0, 0, width, height);
    
    return self.imageViewRect;
    
}

/**
 *  Title rect
 *
 *  @param CGRecttitleRectForContentRect:CGRect content rect
 *
 *  @return title rect
 *
 *  @since 1.0.0
 */
#pragma mark -
#pragma mark setting title label bounds for button
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    //    CGFloat top = contentRect.size.height * 0.58;
    //    CGFloat width = contentRect.size.width;
    //    CGFloat height = contentRect.size.height - top;
    //    return CGRectMake(0, top, width, height);
    
    return self.titleViewRect;
    
}

@end
