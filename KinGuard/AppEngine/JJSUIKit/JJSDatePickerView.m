//
//  JJSDatePickerView.m
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/14.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSDatePickerView.h"

@implementation JJSDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:kWhiteColor];
    }
    return self;
}

- (void)datePickerViewWithTitle:(NSString *)title
{
    // Tool bar view
    UIView *toolBarView = [[UIView alloc] initWithFrame:(CGRect){0, 0, mScreenWidth, 40}];
    [toolBarView setBackgroundColor:[UIColor colorWithRed:0.941 green:0.937 blue:0.957 alpha:1]];
    [toolBarView addSubview:[JJSUtil getSeparator:kSeparatorColor frame:(CGRect){0, 39, mScreenWidth, 1}]];
    [self addSubview:toolBarView];
    
    // Cancel button
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setFrame:(CGRect){10, 5, 48, 30}];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:kNavItemColor forState:UIControlStateNormal];
    [btnCancel setTitleColor:kTableViewCellDetailLabelTextColor forState:UIControlStateHighlighted];
    [btnCancel.titleLabel setFont:kContentFont];
    [btnCancel addTarget:self action:@selector(cancelDatePickerView) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:btnCancel];
    
    // sure button
    UIButton *btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSelect setFrame:(CGRect){mScreenWidth - 58, 5, 48, 30}];
    [btnSelect setTitle:@"完成" forState:UIControlStateNormal];
    [btnSelect setTitleColor:kNavItemColor forState:UIControlStateNormal];
    [btnSelect setTitleColor:kTableViewCellDetailLabelTextColor forState:UIControlStateHighlighted];
    [btnSelect.titleLabel setFont:kContentFont];
    [btnSelect addTarget:self action:@selector(sureDatePickerView) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:btnSelect];
    
    UILabel *labTitle = [[UILabel alloc] initWithFrame:(CGRect){80, 10, mScreenWidth - 160, 20}];
    [labTitle setText:title];
    [labTitle setTextColor:kTableViewCellDetailLabelTextColor];
    [labTitle setTextAlignment:NSTextAlignmentCenter];
    [labTitle setFont:kTitleFontSec];
    [toolBarView addSubview:labTitle];

    self.datePicker = [[UIDatePicker alloc] initWithFrame:(CGRect){0, 40, mScreenWidth, 220}];
    self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker setMinimumDate:[NSDate date]];
    [self addSubview:self.datePicker];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self setFrame:(CGRect){0, mScreenHeight - 260, mScreenWidth, 260}];
    }];
}


- (void)cancelDatePickerView
{
    if ([self.delegate respondsToSelector:@selector(DidSelectCancelDatePickerView)]) {
        [self.delegate DidSelectCancelDatePickerView];
    }
}

- (void)sureDatePickerView
{
//    NSString *dataStr = [NSDate stringFromDate:self.datePicker.date withFormat:@"yyyy-MM-dd"];
   
//    if (self.dateBlock) {
//        self.dateBlock(dataStr);
//    }
    if ([self.delegate respondsToSelector:@selector(DidSelectSureDatePickerView:)]) {
        [self.delegate DidSelectSureDatePickerView:self];
    }
}

@end
