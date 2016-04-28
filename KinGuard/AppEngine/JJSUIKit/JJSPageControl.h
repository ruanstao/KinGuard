//
//  JJSPageControl.h
//  JJSOA
//
//  Created by Koson on 15-2-11.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSPageControl : UIPageControl {

    UIImage *activeImage;
    UIImage *inactiveImage;
    NSArray *_usedToRetainOriginalSubview;
    CGFloat kSpacing;
}

@end
