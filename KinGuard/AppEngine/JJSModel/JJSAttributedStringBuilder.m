
//
//  Created by qhl on 15/6/18.

//  Copyright (c) 2015年 jjs. All rights reserved.
//

#import "JJSAttributedStringBuilder.h"


@implementation JJSAttributedStringRange
{
    NSMutableArray *_ranges;
    NSMutableAttributedString *_attrString;
    
    JJSAttributedStringBuilder *_builder;
    
}


- (id)initWithAttributeString:(NSMutableAttributedString *)attrString builder:(JJSAttributedStringBuilder *)builder
{
    self = [self init];
    if (self != nil)
    {
        _attrString = attrString;
        _builder = builder;
        _ranges = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addRange:(NSRange)range
{
    [_ranges addObject:[NSValue valueWithRange:range]];
}

- (void)enumRange:(void(^)(NSRange range))block
{
    if (self == nil || _attrString == nil)
        return;
    
    for (int i = 0; i < _ranges.count; i++)
    {
        NSRange range = ((NSValue *)[_ranges objectAtIndex:i]).rangeValue;
        if (range.location == NSNotFound || range.length == 0)
            continue;
        
        block(range);
    }
}


- (JJSAttributedStringRange *)setFont:(UIFont*)font
{
    
    
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSFontAttributeName value:font range:range];
        
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setTextColor:(UIColor *)color
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSForegroundColorAttributeName value:color range:range];
        
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setBackgroundColor:(UIColor *)color
{
    [self enumRange:^(NSRange range){
        
        
        [_attrString addAttribute:NSBackgroundColorAttributeName value:color range:range];
        
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setLigature:(BOOL)ligature
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSLigatureAttributeName value:[NSNumber numberWithInteger:ligature] range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setKern:(CGFloat)kern
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:kern] range:range];
    }];
    
    return self;
    
}

- (JJSAttributedStringRange *)setLineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle *ps  = [[NSMutableParagraphStyle alloc] init];
    ps.lineSpacing = lineSpacing;
    return [self setParagraphStyle:ps];
}


- (JJSAttributedStringRange *)setStrikethroughStyle:(int)strikethroughStyle
{
    [self enumRange:^(NSRange range){
        
        
        [_attrString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:strikethroughStyle] range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setStrikethroughColor:(UIColor *)strikethroughColor
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSStrikethroughColorAttributeName value:strikethroughColor range:range];
    }];
    
    return self;
}


- (JJSAttributedStringRange *)setUnderlineStyle:(NSUnderlineStyle)underlineStyle
{
    [self enumRange:^(NSRange range){
        [_attrString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:underlineStyle] range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setShadow:(NSShadow *)shadow
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSShadowAttributeName value:shadow range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setTextEffect:(NSString *)textEffect
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSTextEffectAttributeName value:textEffect range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setAttachment:(NSTextAttachment *)attachment
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSAttachmentAttributeName value:attachment range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setLink:(NSURL *)url
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSLinkAttributeName value:url range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setBaselineOffset:(CGFloat)baselineOffset
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSBaselineOffsetAttributeName value:[NSNumber numberWithFloat:baselineOffset] range:range];
    }];
    
    return self;
    
}

- (JJSAttributedStringRange *)setUnderlineColor:(UIColor *)underlineColor
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSUnderlineColorAttributeName value:underlineColor range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setObliqueness:(CGFloat)obliqueness
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSObliquenessAttributeName value:[NSNumber numberWithFloat:obliqueness] range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setExpansion:(CGFloat)expansion
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSExpansionAttributeName value:[NSNumber numberWithFloat:expansion] range:range];
    }];
    
    return self;
    
}

- (JJSAttributedStringRange *)setStrokeColor:(UIColor *)strokeColor
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setStrokeWidth:(CGFloat)strokeWidth
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:strokeWidth] range:range];
    }];
    
    return self;
}

- (JJSAttributedStringRange *)setAttributes:(NSDictionary *)dict
{
    [self enumRange:^(NSRange range){
        
        [_attrString addAttributes:dict range:range];
    }];
    
    return self;
}

- (JJSAttributedStringBuilder *)builder
{
    return _builder;
}

@end


@implementation JJSAttributedStringBuilder
{
    NSMutableAttributedString *attrString;
    NSInteger paragraphIndex;
}

+ (JJSAttributedStringBuilder *)builderWith:(NSString *)string
{
    return [[JJSAttributedStringBuilder alloc] initWithString:string];
}


- (id)initWithString:(NSString *)string
{
    self = [self init];
    if (self != nil)
    {
        if (string != nil)
            attrString = [[NSMutableAttributedString alloc] initWithString:string];
        else
            attrString = nil;
        paragraphIndex = 0;
    }
    
    return self;
}

- (JJSAttributedStringRange *)range:(NSRange)range
{
    if (attrString == nil)
        return nil;
    
    if (attrString.length < range.location + range.length)
        return nil;
    
    
    JJSAttributedStringRange *attrstrrang = [[JJSAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    [attrstrrang addRange:range];
    return attrstrrang;
}

- (JJSAttributedStringRange *)allRange
{
    if (attrString == nil)
        return nil;
    
    NSRange range = NSMakeRange(0, attrString.length);
    return [self range:range];
}

- (JJSAttributedStringRange *)lastRange
{
    if (attrString == nil)
        return nil;
    
    NSRange range = NSMakeRange(attrString.length - 1, 1);
    return [self range:range];
}

- (JJSAttributedStringRange *)lastNRange:(NSInteger)length
{
    if (attrString == nil)
        return nil;
    
    return [self range:NSMakeRange(attrString.length - length, length)];
}


- (JJSAttributedStringRange *)firstRange
{
    if (attrString == nil)
        return nil;
    
    NSRange range = NSMakeRange(0, attrString.length > 0 ? 1 : 0);
    return [self range:range];
}

- (JJSAttributedStringRange *)firstNRange:(NSInteger)length
{
    if (attrString == nil)
        return nil;
    
    return [self range:NSMakeRange(0, length)];
}

- (JJSAttributedStringRange *)characterSet:(NSCharacterSet*)characterSet
{
    if (attrString == nil)
        return nil;
    
    
    //遍历所有字符，然后计算数值
    JJSAttributedStringRange *attrstrrang = [[JJSAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    
    
    NSString *str = attrString.string;
    NSRange range;
    BOOL isStart = YES;
    for (int i = 0; i < str.length; i++)
    {
        unichar uc  = [str characterAtIndex:i];
        if ([characterSet characterIsMember:uc])
        {
            if (isStart)
            {
                range.location = i;
                range.length = 0;
                isStart = NO;
            }
            
            range.length++;
        }
        else
        {
            if (!isStart)
            {
                isStart = YES;
                
                [attrstrrang addRange:range];
            }
        }
    }
    
    if (!isStart)
        [attrstrrang addRange:range];
    
    return attrstrrang;
}


- (JJSAttributedStringRange *)searchString:(NSString *)searchString options:(NSStringCompareOptions)options all:(BOOL)all
{
    if (attrString == nil)
        return nil;
    
    
    JJSAttributedStringRange *attRange = [[JJSAttributedStringRange alloc] initWithAttributeString:attrString builder:self];
    NSString *str = attrString.string;
    if (!all)
    {
        return [self range:[str rangeOfString:searchString options:options]];
    }
    else
    {
        NSRange searchRange = NSMakeRange(0, str.length);
        NSRange range = NSMakeRange(0, 0);
        
        while(range.location != NSNotFound && searchRange.location < str.length)
        {
            range = [str rangeOfString:searchString options:options range:searchRange];
            [attRange addRange:range];
            if (range.location != NSNotFound)
            {
                searchRange.location = range.location + range.length;
                searchRange.length = str.length - searchRange.location;
            }
        }
        
        
    }
    
    return attRange;
    
}

- (JJSAttributedStringRange *)includeString:(NSString *)includeString all:(BOOL)all
{
    return [self searchString:includeString options:0 all:all];
}

- (JJSAttributedStringRange *)regularExpression:(NSString*)regularExpression all:(BOOL)all
{
    return [self searchString:regularExpression options:NSRegularExpressionSearch all:all];
}

- (JJSAttributedStringRange *)firstParagraph
{
    if (attrString == nil)
        return nil;
    
    
    paragraphIndex = 0;
    
    NSString *str = attrString.string;
    NSRange range;
    NSInteger i;
    for (i = paragraphIndex; i < str.length; i++)
    {
        unichar uc = [str characterAtIndex:i];
        if (uc == '\n')
        {
            range.location =  0;
            range.length = i + 1;
            paragraphIndex = i + 1;
            break;
        }
    }
    
    if (i >= str.length)
    {
        range.location = 0;
        range.length = i;
        paragraphIndex = i;
    }
    
    
    return [self range:range];
}

- (JJSAttributedStringRange *)nextParagraph
{
    if (attrString == nil)
        return nil;
    
    NSString *str = attrString.string;
    
    if (paragraphIndex >= str.length)
        return nil;
    
    
    NSRange range;
    NSInteger i;
    for (i = paragraphIndex; i < str.length; i++)
    {
        unichar uc = [str characterAtIndex:i];
        if (uc == '\n')
        {
            range.location =  paragraphIndex;
            range.length = i - paragraphIndex + 1;
            paragraphIndex = i + 1;
            break;
        }
    }
    
    if (i >= str.length)
    {
        range.location = paragraphIndex;
        range.length = i - paragraphIndex;
        paragraphIndex = i + 1;
    }
    
    
    return [self range:range];
}


- (void)insert:(NSInteger)pos attrstring:(NSAttributedString *)attrstring
{
    if (attrString == nil || attrstring == nil)
        return;
    
    if (pos == -1)
        [attrString appendAttributedString:attrstring];
    else
        [attrString insertAttributedString:attrstring atIndex:pos];
}

- (void)insert:(NSInteger)pos attrBuilder:(JJSAttributedStringBuilder *)attrBuilder
{
    [self insert:pos attrstring:attrBuilder.commit];
}

- (NSAttributedString*)commit
{
    return attrString;
}




@end
