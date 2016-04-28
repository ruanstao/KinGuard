//
//  UIButton+Block.h
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/1/13.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>


typedef void (^ActionBlock)();

@interface UIButton (Block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end
