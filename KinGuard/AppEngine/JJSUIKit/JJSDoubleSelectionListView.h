//
//  JJSDoubleSelectionListView.h
//  JJSOA
//
//  Created by RuanSTao on 16/4/13.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JJSDoubleSelectionListView;

//@protocol JJSDoubleSelectionListViewDelegate <NSObject>
//
///**
// *  取消按钮点击事件
// */
//- (void)cancelSelectionListView;
//
///**
// *  选择某一行的代理
// *
// *  @param row   选择了哪一行
// *  @param value 所选择的行对应的value值
// *  @param name  所选择行对应的name值
// */
//@optional
//- (void)didSelectRowAtIndexPath:(NSInteger)row value:(NSInteger)value name:(NSString *)name;
//
//- (void)didSelectRowAtIndexPath:(NSInteger)row value:(NSInteger)value name:(NSString *)name otherParams:(NSDictionary *)otherParams;

//@end


@interface JJSDoubleSelectionListView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

- (void)listViewWithTitle:(NSString *)title;

@property (nonatomic,copy)void(^customerInit)(JJSDoubleSelectionListView *listView,UIPickerView *pickerView);

@property (nonatomic,copy)void(^cancelInputActioin)();
@property (nonatomic,copy)void(^selectInputAction)(UIPickerView *pickerView);

@property (nonatomic,copy) NSNumber *(^numberOfComponentsInPickerView)(UIPickerView *pickerView);

@property (nonatomic,copy) NSNumber *(^pickerViewRowHeightForComponent)(UIPickerView *pickerView,NSInteger component);

@property (nonatomic,copy) NSNumber *(^pickerViewNumBerOfRowsInComponent)(UIPickerView *pickerView,NSInteger component);

@property (nonatomic,copy)void (^pickerViewDidSelectRowInComponent)(UIPickerView *pickerView,NSInteger row ,NSInteger component);

@property (nonatomic,copy)UIView *(^pickerViewForRowComponentReusingView)(UIPickerView * pickerView ,NSInteger row , NSInteger component,UIView *view);

@end
