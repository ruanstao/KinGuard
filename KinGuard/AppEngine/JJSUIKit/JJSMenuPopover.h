//
//  JJSMenuPopover.h
//  JJSMenuPopover
//
//  Created by 邱弘宇 on 16/1/15.
//  Copyright © 2016年 JJS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJSMenuPopover;
typedef NS_ENUM(NSUInteger,JJSMenuPopoverDirection){
    JJSMenuPopoverDirectionVertical = 1,//竖直方向
    JJSMenuPopoverDirectionHorizontal = 2//水平方向
};
typedef  void(^ _Nullable JJSMenuPopoverCallback)(NSInteger selectItem);
JJSMenuPopoverCallback _JJSMenuPopOverCallback;
@interface JJSMenuPopover : UIView

//@property(nonatomic,strong)JJSMenuPopoverCallback callback;

+ (instancetype)showFromView:( UIView * _Nonnull )view direction:(JJSMenuPopoverDirection)direction menuItems: (NSArray<NSString *> * _Nonnull)menuItems withCallBack:(JJSMenuPopoverCallback)callback;

- (void)dismissMenuPopover;
@end
