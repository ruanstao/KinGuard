//
//  JJSChoseView.h
//  JJSOA
//
//  Created by jjs on 15-3-2.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSChoseView : UIView
{
    NSArray *array;
}
@property (nonatomic , copy) void (^ClickActionBlock)(JJSButton *sender);

- (id)initWithFrame:(CGRect)frame withTitle:(NSArray *)titleArray withArrow:(BOOL)isArrow withSeparator:(BOOL)isLine;

@end
