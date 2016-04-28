//
//  NSString+Regular.h
//  MaxLife
//
//  Created by Koson Gou on 8/7/14.
//  Copyright (c) 2014 Kineticspace Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regular)

- (BOOL)isValidateEmail;//驗證郵件合法性
- (BOOL)isNumber;//驗證全部是數字
- (BOOL)isEnglishWords;//驗證是英文字母
- (BOOL)isValidatePassword;//驗證密碼：6～16位，只能包含字符、數字和下劃線。
- (BOOL)isChineseWords;//驗證是否為漢字
- (BOOL)isInternetUrl;//驗證是否為網絡鏈接
- (BOOL)isPhoneNumber;//驗證是否為電話號碼。正確格式：XXXX-XXXXXXX，XXXX-XXXXXXXX，XXX-XXXXXXX，XXX-XXXXXXXX，XXXXXXX，XXXXXXXX
- (BOOL)isElevenDigitNum;//判斷是否為11位數字
- (BOOL)isIdentifyCardNumber;//驗證15或者18位身份證。
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


@end
