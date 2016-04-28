//
//  JJSViewController+Title.h
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/11.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSViewController.h"

@interface JJSViewController (Title)

/**
 *  添加标题右侧按钮（文字型）
 *
 *  @param name 按钮名称
 */
- (void)addTitleRightBtnWithName:(NSString *)name;

/**
 *  添加标题右侧按钮（图片型）
 *
 *  @param imgName 按钮图片名称
 */
- (void)addTitleRightBtnWithImage:(NSString *)imgName;

/**
 *  标题右侧按钮点击事件
 */
- (IBAction)rightBtnAction;

@end
