//
//
//  Created by qhl on 15/6/18.
//  Copyright (c) 2015年 jjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JJSAttributedStringBuilder;

/**属性字符串区域***/
@interface JJSAttributedStringRange : NSObject


- (JJSAttributedStringRange *)setFont:(UIFont*)font;              //字体
- (JJSAttributedStringRange *)setTextColor:(UIColor*)color;       //文字颜色
- (JJSAttributedStringRange *)setBackgroundColor:(UIColor*)color; //背景色
- (JJSAttributedStringRange *)setParagraphStyle:(NSParagraphStyle *)paragraphStyle;  //段落样式
- (JJSAttributedStringRange *)setLigature:(BOOL)ligature;  //连体字符，好像没有什么作用
- (JJSAttributedStringRange *)setKern:(CGFloat)kern; //字间距
- (JJSAttributedStringRange *)setLineSpacing:(CGFloat)lineSpacing;   //行间距
- (JJSAttributedStringRange *)setStrikethroughStyle:(int)strikethroughStyle;  //删除线
- (JJSAttributedStringRange *)setStrikethroughColor:(UIColor*)StrikethroughColor NS_AVAILABLE_IOS(7_0);  //删除线颜色
- (JJSAttributedStringRange *)setUnderlineStyle:(NSUnderlineStyle)underlineStyle; //下划线
- (JJSAttributedStringRange *)setUnderlineColor:(UIColor*)underlineColor NS_AVAILABLE_IOS(7_0);  //下划线颜色
- (JJSAttributedStringRange *)setShadow:(NSShadow *)shadow;    //阴影
- (JJSAttributedStringRange *)setTextEffect:(NSString *)textEffect NS_AVAILABLE_IOS(7_0);
- (JJSAttributedStringRange *)setAttachment:(NSTextAttachment *)attachment NS_AVAILABLE_IOS(7_0); //将区域中的特殊字符: NSAttachmentCharacter,替换为attachement中指定的图片,这个来实现图片混排。
- (JJSAttributedStringRange *)setLink:(NSURL *)url NS_AVAILABLE_IOS(7_0);   //设置区域内的文字点击后打开的链接
- (JJSAttributedStringRange *)setBaselineOffset:(CGFloat)baselineOffset NS_AVAILABLE_IOS(7_0);  //设置基线的偏移量，正值为往上，负值为往下，可以用于控制UILabel的居顶或者居低显示
- (JJSAttributedStringRange *)setObliqueness:(CGFloat)obliqueness NS_AVAILABLE_IOS(7_0);   //设置倾斜度
- (JJSAttributedStringRange *)setExpansion:(CGFloat)expansion NS_AVAILABLE_IOS(7_0);  //压缩文字，正值为伸，负值为缩

- (JJSAttributedStringRange *)setStrokeColor:(UIColor*)strokeColor;  //中空文字的颜色
- (JJSAttributedStringRange *)setStrokeWidth:(CGFloat)strokeWidth;   //中空的线宽度


//可以设置多个属性
- (JJSAttributedStringRange *)setAttributes:(NSDictionary *)dict;

//得到构建器
- (JJSAttributedStringBuilder *)builder;

@end


/*属性字符串构建器*/
@interface JJSAttributedStringBuilder : NSObject

+ (JJSAttributedStringBuilder *)builderWith:(NSString *)string;


- (id)initWithString:(NSString *)string;

- (JJSAttributedStringRange *)range:(NSRange)range;  //指定区域,如果没有属性串或者字符串为nil则返回nil,下面方法一样。
- (JJSAttributedStringRange *)allRange;      //全部字符
- (JJSAttributedStringRange *)lastRange;     //最后一个字符
- (JJSAttributedStringRange *)lastNRange:(NSInteger)length;  //最后N个字符
- (JJSAttributedStringRange *)firstRange;    //第一个字符
- (JJSAttributedStringRange *)firstNRange:(NSInteger)length;  //前面N个字符
- (JJSAttributedStringRange *)characterSet:(NSCharacterSet *)characterSet; //用于选择特殊的字符
- (JJSAttributedStringRange *)includeString:(NSString *)includeString all:(BOOL)all;   //用于选择特殊的字符串
- (JJSAttributedStringRange *)regularExpression:(NSString *)regularExpression all:(BOOL)all;   //正则表达式


//段落处理,以\n结尾为一段，如果没有段落则返回nil
- (JJSAttributedStringRange *)firstParagraph;
- (JJSAttributedStringRange *)nextParagraph;


//插入，如果为0则是头部，如果为-1则是尾部
- (void)insert:(NSInteger)pos attrstring:(NSAttributedString *)attrstring;
- (void)insert:(NSInteger)pos attrBuilder:(JJSAttributedStringBuilder *)attrBuilder;

- (NSAttributedString *)commit;


@end
