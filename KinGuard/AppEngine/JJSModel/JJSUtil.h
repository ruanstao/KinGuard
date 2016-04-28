//
//  KSTableViewTools.h
//  MaxLife
//
//  Created by Koson Gou on 1/7/14.
//  Copyright (c) 2014 Kineticspace Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  It's convenient utils
 *
 *  @since 1.0.0
 */
@interface JJSUtil : NSObject

//Success And Failed Blocks
typedef void (^KSFinishedBlock) (NSDictionary *data);
typedef void (^KSFailedBlock)   (NSString *error);
typedef void (^KSUploadProgress) (float progressValue);

//Load More And Update Data Block
typedef void (^KSLoadMoreDataBlock) (void);
typedef void (^KSUpdateDataBlock) (void);

//Completion Block(with object)
typedef void (^CompletionWithObjectBlock) (BOOL finish, id obj);
typedef void (^CompletionWithDoubleBlock) (BOOL finish, id obj, id obj2);
typedef void (^CompletionBlock)(BOOL finish);

+ (void)setExtraCellLineHidden:(UITableView *)tableView;

+ (void)deselectTableViewCell:(UITableView *)tableView;

+ (BOOL)IsNetWork;

+ (BOOL)isBlankString:(NSString *)string;

//标签空值 显示字符串
+ (NSString *)laberNil:(NSString *)string;

+ (BOOL)isContainsQuote:(NSString *)string;

//+ (void)showTitleInView:(NSString *)title view:(UIView *)view;
//
//+ (void)showWaitViewWithTitleInView:(NSString *)title view:(UIView *)view;
//
//+ (void)removeWaitViewWithReplaceTitleInView:(NSString *)title view:(UIView *)view;

+ (BOOL)validateEmail:(NSString *)candidate;

+ (void)storageDataWithObject:(id)obj Key:(NSString *)key Completion:(CompletionWithObjectBlock)completion;

+ (void)getDataWithKey:(NSString *)key Completion:(CompletionWithObjectBlock)completion;

+ (UIImage *)imageWithColor:(UIColor *)color Size:(CGRect)size;

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;

+ (NSDateFormatter*)getDateFormatWithStyle:(NSString *)style;
/*
 获取字符串的宽度
 */
+ (float)widthForString:(NSString *)value Font:(UIFont *)font andHeight:(float)height;
+ (float)heightForString:(NSString *)value Font:(UIFont *)font andWidth:(float)width;

+ (CGRect)stringWithFont:(UIFont *)font withWidth:(CGFloat)width withContent:(NSString *)string;

+ (UIColor *)colorWithString:(NSString *)string;

+ (NSString *)copyDataBaseWithFileFullName:(NSString *)name CustomerDir:(NSString *)dir Override:(BOOL)ovrid;

// Show information message at window
+ (void)showHUDWithMessage:(NSString*)message autoHide:(BOOL)needAutoHide;

+ (void)changeHUDMessage:(NSString*)message;

+ (void)hideHUD;

+ (void)showHUDWithWaitingMessage:(NSString *)message;

// Check if the input text contains non-English character
+ (BOOL)isEnglishCharacterOnly:(NSString*)input;

// Capture the current screenshot
+ (UIImage*)captureScreen;

/**
 *  Description:flatten html tag and blank
 *
 *  @param  str  string by your self
 *  @param  trim flatten blank string
 *
 *  @return string after flatten
 */
+ (NSString *)flattenHTML:(NSString *)str trimBlank:(BOOL)trim;

/**
 *  Description: Append more arguments(尚未使用阶段，应修订)
 *
 *  @param  firstObjects first object
 *
 *  @return append result
 */
+ (NSString *)appendMoreArguments:(NSString *)firstObjects,...NS_REQUIRES_NIL_TERMINATION;
/**
 *  Description:去除地址中括号里的内容
 */
+ (NSString *)flattenAddress:(NSString *)address;

/**
 *  Description: Generator separator view
 *
 *  @param color separator background color
 *  @param frame separator frame
 *
 *  @return separator view
 */
+ (UIView *)getSeparator:(UIColor *)color frame:(CGRect)frame;

/**
 *  Description: Validate mobile phone number
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  Description: Validate digitnumber with length
 */
+ (BOOL)isDigitNumber:(NSString *)string Length:(NSInteger)length;
/**
 *  Description: 打开本地文件
 */
+ (NSArray *)arrayWithFileName:(NSString *)filename;
/**
 *  Description: 判断图片链接是否有http://img.jjshome.com前缀
 */
+ (NSString *)imageUrlWith:(NSString *)path;
/**
 *  Description:判断是网络图片还是相册图片
 */
+ (BOOL)imageUrlWithHexFix:(NSString *)path;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;
//
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//判断图片后缀
+ (NSString *)isImageSy:(NSString *)string;

//根据面积类型返回字符串
+ (NSString *)rsAreaWithType:(NSInteger)type;

//根据物业类型返回字符串
+ (NSString *)rqPropertyUseWithType:(NSInteger)type;

//租售目的类型返回字符串
+ (NSString *)rqBuyPurposeWithType:(NSInteger)type;

//户型类型返回字符串
+ (NSString *)rqHxWithType:(NSInteger)type;

//根据租售类型和起始 结束价位 返回字符串
+ (NSString *)rqPriceWith:(NSInteger)rqType with:(NSInteger)rqPrice;

/**
 *  验证身份证位数
 */
+ (BOOL)easyVerifyIDCardNumber:(NSString *)value;

+ (BOOL)verifyIDCardNumber:(NSString *)value;

+ (NSString *)getTypeWithString:(id)data;

+ (NSUInteger)numberOfMatchesInString:(NSString *)string RegexString:(NSString *)regexString;

+ (NSString * ) jsonStringWithDictionary:(NSDictionary *) dic;

+ (void)circleFilledWithOutline:(UIView *)circleView fillColor:(UIColor *)fillColor outlineColor:(UIColor*)outlinecolor;

+ (NSString *)encryptionString:(NSString *)string;

+ (NSString *)encryptionStringByIndex:(int)length;

+ (NSString *)stringByReversed:(NSString *)str;

+ (NSString *)timeDateFormatter:(NSDate *)date type:(int)type;

+ (NSString *)changeFloat:(NSString *)stringFloat;

+ (instancetype)getClassObjectFormNib:(NSString *)nibString;

/**
 *  定义一个蓝色的圆角按钮
 *  @param btnName 按钮名称
 */
+ (UIButton *)blueRectButtonWithName:(NSString *)btnName;

/**
 *  页面内定义一个scrollView
 *
 *  @return JJSScrollView
 */
+ (JJSScrollView *)initializeViewWithScrollView:(CGRect)frame;

/**
 *  是否只有中文
 *
 *  @param string
 *
 *  @return yes 是，no 否
 */
+ (BOOL)isOnlyChinese:(NSString *)string;

@end
