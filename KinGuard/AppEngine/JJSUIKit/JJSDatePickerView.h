//
//  JJSDatePickerView.h
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/14.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DatePickerBlock)(NSString *dateStr);

@class JJSDatePickerView;

@protocol JJSDatePickerViewDelegate <NSObject>

/**
 *  取消按钮点击事件
 */
- (void)DidSelectCancelDatePickerView;

/**
 *  确定按钮点击事件
 */
- (void)DidSelectSureDatePickerView:(JJSDatePickerView *)datePicker;


@end

@interface JJSDatePickerView : UIView

@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,copy) NSString *chooseDateStr;
//@property (nonatomic,copy) DatePickerBlock *sureDateBlock;

@property (nonatomic,assign) id <JJSDatePickerViewDelegate> delegate;

/**
 *  初始化页面
 */
- (void)datePickerViewWithTitle:(NSString *)title;

/**
 *  取消按钮点击事件
 */
- (void)cancelDatePickerView;

/**
 *  确定按钮点击事件
 */
- (void)sureDatePickerView;

@end




////////////*******************实例*********************////////
//#pragma mark 弹出日期选择器
//- (void)toggleDatePicker:(BOOL)show
//{
//    if (show) {
//        [self showAlphaBackgroundView:YES];
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelDatePickerView)];
//        [tap setNumberOfTapsRequired:1];
//        [tap setNumberOfTouchesRequired:1];
//        [[self alphaBackgroundView] addGestureRecognizer:tap];
//        
//        //初始化弹出列表
//        datePickerView = [[JJSDatePickerView alloc] initWithFrame:CGRectMake(0, mScreenHeight, mScreenWidth, 260)];
//        [datePickerView datePickerViewWithTitle:@""];
//        datePickerView.delegate = self;
//        
//        [self.navigationController.view addSubview:datePickerView];
//        
//    }
//}
//
//- (void)cancelDatePickerView
//{
//    [self DidSelectCancelDatePickerView];
//}
//
//#pragma mark -弹出的日期选择器View代理
///**
// *  取消按钮点击事件
// */
//- (void)DidSelectCancelDatePickerView
//{
//    [self hideAlphaBackgroundView:YES];
//    [UIView animateWithDuration:0.3 animations:^{
//        [datePickerView setFrame:(CGRect){0, mScreenHeight, mScreenWidth, 260}];
//        
//    } completion:^(BOOL finished) {
//        [[datePickerView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            [obj removeFromSuperview];
//        }];
//        [datePickerView removeFromSuperview];
//    }];
//}
//
///**
// *  确定按钮点击事件
// */
//- (void)DidSelectSureDatePickerView:(NSString *)dateStr
//{
//    [self DidSelectCancelDatePickerView];
//    self.endDates = dateStr;
//}
//
