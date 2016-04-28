//
//  JJSDoubleSelectionListView.m
//  JJSOA
//
//  Created by RuanSTao on 16/4/13.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSDoubleSelectionListView.h"

@interface JJSDoubleSelectionListView()
@property (nonatomic,strong)UIPickerView *pickerView;
@end

@implementation JJSDoubleSelectionListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)listViewWithTitle:(NSString *)title
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
    [btnCancel addTarget:self action:@selector(cancelInputPickerView) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:btnCancel];

    UIButton *btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSelect setFrame:(CGRect){mScreenWidth - 58, 5, 48, 30}];
    [btnSelect setTitle:@"完成" forState:UIControlStateNormal];
    [btnSelect setTitleColor:kNavItemColor forState:UIControlStateNormal];
    [btnSelect setTitleColor:kTableViewCellDetailLabelTextColor forState:UIControlStateHighlighted];
    [btnSelect.titleLabel setFont:kContentFont];
    [btnSelect addTarget:self action:@selector(numberPickerSelected:) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:btnSelect];


    UILabel *labTitle = [[UILabel alloc] initWithFrame:(CGRect){80, 10, mScreenWidth - 160, 20}];
    [labTitle setText:title];
    [labTitle setTextColor:kTableViewCellDetailLabelTextColor];
    [labTitle setTextAlignment:NSTextAlignmentCenter];
    [labTitle setFont:kTitleFontSec];
    [toolBarView addSubview:labTitle];

    self.pickerView = [[UIPickerView alloc] initWithFrame:(CGRect){0, 40, mScreenWidth, 220}];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView setBackgroundColor:[UIColor colorWithRed:0.961 green:0.961 blue:0.961 alpha:1]];
    [self addSubview:self.pickerView];

    if (self.customerInit) {
        self.customerInit(self,self.pickerView);
    }
    [UIView animateWithDuration:0.3f animations:^{

        [self setFrame:(CGRect){0, mScreenHeight - 260, mScreenWidth, 260}];

    }];



}


- (void)cancelInputPickerView
{
    if (self.cancelInputActioin) {
        self.cancelInputActioin();
    }
}
- (void)numberPickerSelected:(id)sender
{

    // Set house number and storage
    if (self.selectInputAction) {
        self.selectInputAction(self.pickerView);
    }

    [self cancelInputPickerView];
}

#pragma mark -
#pragma mark UIPickerView Delegate & DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.numberOfComponentsInPickerView) {
        return [self.numberOfComponentsInPickerView(pickerView) integerValue];
    }else{
        return 2;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (self.pickerViewRowHeightForComponent) {
        return [self.pickerViewRowHeightForComponent(pickerView,component) floatValue];
    }else{
        return 40;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return [self.pickerViewNumBerOfRowsInComponent(pickerView,component) integerValue];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    self.pickerViewDidSelectRowInComponent(pickerView,row,component);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    return self.pickerViewForRowComponentReusingView(pickerView,row,component,view);

}

@end
