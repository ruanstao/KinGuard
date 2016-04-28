//
//  JJSGestureLockView.h
//  JJSKit
//
//  Created by YD-Guozuhong on 15/8/1.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJSGestureLockView;

@protocol JJSGestureLockViewDelegate <NSObject>

@optional
- (void)gestureLockView:(JJSGestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(JJSGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(JJSGestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode;

@end

@interface JJSGestureLockView : UIView

@property (nonatomic, strong, readonly) NSArray *buttons;
@property (nonatomic, strong, readonly) NSMutableArray *selectedButtons;

@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;

@property (nonatomic, strong) UIImage *normalGestureNodeImage;
@property (nonatomic, strong) UIImage *selectedGestureNodeImage;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  Description: Container of all gesture notes
 */
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, weak) id<JJSGestureLockViewDelegate> delegate;

@end
