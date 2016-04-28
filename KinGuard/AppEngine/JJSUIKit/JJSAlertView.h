//
//  JJSAlertView.h
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/4/11.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^buttonBlock) (void);

@interface JJSAlertView : UIView

@property (nonatomic ,strong) UIColor *titleColor;

@property (nonatomic ,strong) UIColor *msgColor;

@property (nonatomic ,strong) UIColor *btnColor;

- (void)initWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle withButtonBlock:(buttonBlock)block;

-(void)dismiss;

@end
