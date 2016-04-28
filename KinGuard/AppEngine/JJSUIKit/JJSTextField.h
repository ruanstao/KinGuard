//
//  JJSTextField.h
//  JJSOA
//
//  Created by Koson on 15-2-11.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSTextField : UITextField

@property (nonatomic) BOOL required;
@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSString *dateFormat;
@property (nonatomic, setter = setDateField:) BOOL isDateField;
@property (nonatomic, setter = setEmailField:) BOOL isEmailField;

- (BOOL) validate;
- (void) setDateFieldWithFormat:(NSString *)dateFormat;

@end
