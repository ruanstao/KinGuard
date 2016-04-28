//
//  JJSMutilSelectionListView.h
//  JJSOA
//
//  Created by RuanSTao on 16/4/21.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSMutilSelectionListView : UIView <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) NSArray *inputDataSource;
/**
 *  初始化控件
 *
 *  @param title 标题
 */
- (void)listViewWithTitle:(NSString *)title;


/**
 *  回调block
 */

/**
 *  取消按钮点击事件
 */
@property (nonatomic,copy)void (^cancelSelectionListView)();

/**
 *  完成按钮点击事件
 */
@property (nonatomic,copy)void (^doneSelectionListView)(NSArray *selectArray);


/**
 *  选择某一行的代理
 *
 *  @param row   选择了哪一行
 *  @param value 所选择的行对应的value值
 *  @param name  所选择行对应的name值
 */
@property (nonatomic,copy)void (^didSelectRowAtIndexPath_Value_Name)(NSInteger row,NSInteger value,NSString *name);

@property (nonatomic,copy)void (^didSelectRowAtIndexPath_Value_Name_OtherParams)(NSInteger row,NSInteger value,NSString *name,NSDictionary *otherParams);


@end
