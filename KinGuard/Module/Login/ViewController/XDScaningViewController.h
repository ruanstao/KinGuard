//
//  XDScaningViewController.h
//  XDQRCode
//
//  Created by DINGYONGGANG on 15/9/26.
//  Copyright (c) 2015年 DINGYONGGANG. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Config.h"
#import <QuartzCore/QuartzCore.h>
/**
 *  扫描二维码控制器
 */
@interface XDScaningViewController : UIViewController

@property (nonatomic, copy) void (^backValue)(NSString *scannedStr);

@end


@class XDScanningView;
@protocol XDScanningViewDelegate <NSObject>

- (void)view:(UIView*)view didCatchGesture:(UIGestureRecognizer *)gesture;

@end

@interface XDScanningView : UIView
@property (weak, nonatomic) id<XDScanningViewDelegate> delegate;
+ (NSInteger)width;
+ (NSInteger)height;
@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com