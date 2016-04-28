//
//  JJSPageControl.m
//  JJSOA
//
//  Created by Koson on 15-2-11.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSPageControl.h"

@implementation JJSPageControl

// For ios 6
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self)
//    {
////        activeImage = [UIImage imageNamed:@"active_page_image.png"];
////        inactiveImage = [UIImage imageNamed:@"inactive_page_image.png"];
//
//        activeImage = [JJSUtil imageWithColor:[UIColor redColor] Size:CGRectMake(0, 0, 10, 10)];
//        inactiveImage = [JJSUtil imageWithColor:[UIColor whiteColor] Size:CGRectMake(0, 0, 10, 10)];
//    
//    }
//    return self;
//}
//
//- (id)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self)
//    {
////        activeImage = [UIImage imageNamed:@"active_page_image.png"];
////        inactiveImage = [UIImage imageNamed:@"inactive_page_image.png"];
//        activeImage = [JJSUtil imageWithColor:[UIColor redColor] Size:CGRectMake(0, 0, 10, 10)];
//        inactiveImage = [JJSUtil imageWithColor:[UIColor whiteColor] Size:CGRectMake(0, 0, 10, 10)];
//        
//    }
//    return self;
//}
//
//- (void)updateDots
//{
//    for (int i = 0; i < [self.subviews count]; i++)
//    {
//        UIImageView* dot = [self.subviews objectAtIndex:i];
//        if (i == self.currentPage) dot.image = activeImage;
//        else dot.image = inactiveImage;
//    }
//}
//
//- (void)setCurrentPage:(NSInteger)page
//{
//    [super setCurrentPage:page];
//    [self updateDots];
//}

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    
    if ([self respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)] && [self respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
        [self setCurrentPageIndicatorTintColor:[UIColor clearColor]];
        [self setPageIndicatorTintColor:[UIColor clearColor]];
    }
    
    [self setBackgroundColor:[UIColor clearColor]];
    activeImage= [JJSUtil imageWithColor:[UIColor redColor] Size:CGRectMake(0, 0, 10, 10)];
    inactiveImage= [JJSUtil imageWithColor:[UIColor whiteColor] Size:CGRectMake(0, 0, 10, 10)];
    
    kSpacing = 10.0f;
    
    // 原来pagecontroll的subview
    _usedToRetainOriginalSubview=[NSArray arrayWithArray:self.subviews];
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    self.contentMode=UIViewContentModeRedraw;
    return self;
    
}

-(void)dealloc
{
    // 释放原来的那些subview
    _usedToRetainOriginalSubview=nil;
    activeImage=nil;
    inactiveImage=nil;
}

- (void)updateDots
{
    
    for (int i = 0; i< [self.subviews count]; i++) {
        UIImageView* dot =[self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=activeImage;
            }
            
        } else {
            if ([dot respondsToSelector:@selector(setImage:)]) {
                dot.image=inactiveImage;
            }
        }
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <=6.0) {
        [self updateDots];
    }
    //    [self updateDots];
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    [super setNumberOfPages:numberOfPages];
    if ([[[UIDevice currentDevice]systemVersion]floatValue] <=6.0) {
        [self updateDots];
    }
    //    [self updateDots];
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)iRect
{
    if (mIsIOS7OrLater){
        //加个判断
        int i;
        CGRect rect;
        
        UIImage *image;
        iRect = self.bounds;
        
        if ( self.opaque ) {
            [self.backgroundColor set];
            UIRectFill( iRect );
        }
        
        if ( self.hidesForSinglePage && self.numberOfPages == 1 ) return;
        
        rect.size.height = activeImage.size.height;
        rect.size.width = self.numberOfPages * activeImage.size.width + ( self.numberOfPages - 1 ) * kSpacing;
        rect.origin.x = floorf( ( iRect.size.width - rect.size.width ) / 2.0 );
        rect.origin.y = floorf( ( iRect.size.height - rect.size.height ) / 2.0 );
        rect.size.width = activeImage.size.width;
        
        for ( i = 0; i < self.numberOfPages; ++i ) {
            image = i == self.currentPage ? activeImage : inactiveImage;
            
            [image drawInRect: rect];
            
            rect.origin.x += activeImage.size.width + kSpacing;
        }
    }else {
        
    }
    
}

@end
