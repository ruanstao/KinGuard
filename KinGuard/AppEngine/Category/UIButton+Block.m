//
//  UIButton+Block.m
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/1/13.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "UIButton+Block.h"


@implementation UIButton (Block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}


@end