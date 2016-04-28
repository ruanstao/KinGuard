//
//  UIView+Runtime.h
//  JJSOA
//
//  Created by JJS-iMac on 15/6/3.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Runtime)

- (void)setTapActionWithBlock:(void (^)(void))block;

- (void) removeTapAction;
@end
