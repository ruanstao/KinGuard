//
//  JJSAlertView.m
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/4/11.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSAlertView.h"
#import "UIButton+Block.h"

@interface JJSAlertView ()

 @property (nonatomic ,strong) UIView *bgView;

@end


@implementation JJSAlertView


- (void)initWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)btnTitle withButtonBlock:(buttonBlock)block
{
    // 当前顶层窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    self.bgView = [[UIView alloc] initWithFrame:window.bounds];
    
    self.bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    [window addSubview:self.bgView];
    
   
    self.frame = CGRectMake((window.width-270)/2, (window.height-144)/2, 270, 144);
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.layer.masksToBounds = YES;
    
    self.layer.cornerRadius = 7.0;
    
    [self.bgView addSubview:self];
    
    
    UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 3)];
    [lineImg setImage:mImageByName(@"tabbar_border")];
    [self addSubview:lineImg];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , self.width , 44)];
    titleLbl.text = title;
    titleLbl.font = [UIFont systemFontOfSize:16];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = _titleColor ? _titleColor : [UIColor blackColor];
    [self addSubview:titleLbl];
    
    UILabel *msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 44 , self.width-30 , 44)];
    msgLbl.text = message;
    msgLbl.font = [UIFont systemFontOfSize:13];
    msgLbl.textAlignment = NSTextAlignmentCenter;
    msgLbl.numberOfLines = 0;
    msgLbl.textColor = _msgColor ? _msgColor : [UIColor blackColor];
    [self addSubview:msgLbl];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 98, self.width, 1)];
    lineView.backgroundColor = HexRGB(0xf8f8f8);
    [self addSubview:lineView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.width, 44)];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:_btnColor?_btnColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        block();
    }];
    [self addSubview:btn];
}



-(void)dismiss
{
    [self.bgView removeFromSuperview];
}



@end
