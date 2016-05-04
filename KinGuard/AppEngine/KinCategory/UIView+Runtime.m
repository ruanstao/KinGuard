//
//  UIView+Runtime.m
//  JJSOA
//
//  Created by JJS-iMac on 15/6/3.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "UIView+Runtime.h"
#import <objc/runtime.h>
@implementation UIView (Runtime)

const char * kDTActionHandlerTapGestureKey = "kDTActionHandlerTapGestureKey";
const char * kDTActionHandlerTapBlockKey = "kDTActionHandlerTapBlockKey";

- (void)setTapActionWithBlock:(void (^)(void))block
{
    
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void) removeTapAction
{
    objc_removeAssociatedObjects(self);
}

@end
