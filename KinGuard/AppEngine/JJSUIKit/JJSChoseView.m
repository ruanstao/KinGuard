//
//  JJSChoseView.m
//  JJSOA
//
//  Created by jjs on 15-3-2.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSChoseView.h"
#define BUTTON_TAG 8000

@implementation JJSChoseView

- (id)initWithFrame:(CGRect)frame withTitle:(NSArray *)titleArray withArrow:(BOOL)isArrow withSeparator:(BOOL)isLine
{
    self = [self initWithFrame:frame];
    if (self) {
        array = [titleArray copy];
        CGFloat cWidth = frame.size.width/titleArray.count;
        CGFloat cHeight = frame.size.height;
        [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            CGFloat objWidth = [JJSUtil widthForString:obj Font:kContentFontMiddle andHeight:mScreenWidth];
            
            JJSButton *choseButton = [JJSButton buttonWithType:UIButtonTypeCustom];
            choseButton.frame = (CGRect){idx * cWidth,frame.origin.y,cWidth,cHeight};
            [choseButton setTitle:obj forState:UIControlStateNormal];
            [choseButton setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
            [choseButton setTitleViewRect:(CGRect){0,0,cWidth,cHeight}];
            [choseButton.titleLabel setFont:kContentFontMiddle];
            [choseButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            choseButton.titleLabel.lineBreakMode =  NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
            [choseButton setBackgroundColor:HexRGB(0xf2f2f2)];
            [choseButton setTag:BUTTON_TAG + idx];
            [choseButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:choseButton];
            
            if (isArrow) {
                [choseButton setImageViewRect:CGRectMake((cWidth - objWidth)/2 + objWidth + 3.f, cHeight/2 - 1.5f, 6.f, 3.f)];
                [choseButton setImage:mImageByName(@"quick_search_down") forState:UIControlStateNormal];
            }
            if (isLine) {
                if (idx != 0) {
                    UIView *line = [[UIView alloc] initWithFrame:(CGRect){cWidth * idx,0,0.5f,cHeight}];
                    line.backgroundColor = HexRGB(0xe8e8e8);
                    [self addSubview:line];
                }
            }
        }];
        [self addSubview:[JJSUtil getSeparator:HexRGB(0xe8e8e8) frame:(CGRect){0,cHeight - 0.618,frame.size.width,0.618}]];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)buttonClick:(JJSButton *)sender
{
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[JJSButton class]]) {
            if (sender.tag != [(JJSButton *)subView tag]) {
                [(JJSButton *)subView setClicked:NO];
            }
            
            [(JJSButton *)subView setImage:mImageByName(@"quick_search_down") forState:UIControlStateNormal];
            [(JJSButton *)subView setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
        }
    }
    if (self.ClickActionBlock) {
        self.ClickActionBlock(sender);
    }
}

@end
