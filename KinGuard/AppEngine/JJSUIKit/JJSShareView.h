//
//  JJSShareView.h
//  JJSMOA
//
//  Created by JJSAdmin on 15/6/30.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSShareView : UIView

//分享类型
typedef enum : NSUInteger {
    
    SHARE_WEIXIN = 10001,  //微信分享
    SHARE_QQ = 10002,      //QQ分享
    SHARE_MESSAGE
} ShareType;

typedef void (^JJSShareViewBlock)(ShareType sType);

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) JJSShareViewBlock block;

- (void)animateShow:(BOOL)show completionBlock:(JJSShareViewBlock)completion;

@end
