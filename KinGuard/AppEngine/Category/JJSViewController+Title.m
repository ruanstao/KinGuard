//
//  JJSViewController+Title.m
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/11.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSViewController+Title.h"

@implementation JJSViewController (Title)

/**
 *  添加标题右侧按钮（文字型）
 *
 *  @param name 按钮名称
 */
- (void)addTitleRightBtnWithName:(NSString *)name
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
    [rightItem setTintColor:kNavItemColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  添加标题右侧按钮（图片型）
 *
 *  @param imgName 按钮图片名称
 */
- (void)addTitleRightBtnWithImage:(NSString *)imgName
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imgName] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
    [rightItem setTintColor:kNavItemColor];
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  标题右侧按钮点击事件
 */
- (IBAction)rightBtnAction
{
    
}

@end
  