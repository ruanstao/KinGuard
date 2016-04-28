//
//  JJSNoticeView.m
//  JJSOA
//
//  Created by YD-Guozuhong on 16/3/25.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSNoticeView.h"

@implementation JJSNoticeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)configureWithBackgroundColor:(UIColor *)color NoticeContent:(NSString *)content closeButtonImageName:(NSString *)imageName
{
    // Simple configure
    [self setBackgroundColor:color ? : [UIColor yellowColor]];
//    [self setAlpha:0.8];

    // Set content
    if (content) {
        UILabel *contentLabel = [[UILabel alloc] init];
        [contentLabel setFrame:CGRectMake(0, (self.height - 18) / 2, self.width, 18)];
        [contentLabel setText:content];
        [contentLabel setFont:kContentFontMiddle];
        [contentLabel setTextAlignment:NSTextAlignmentCenter];
        [contentLabel setTextColor:kTableViewCellDetailLabelTextColor];
        [self addSubview:contentLabel];
    }
    
    if (imageName) {
        
//        UIImage *image = [UIImage imageNamed:imageName];
//        CGFloat width = image.size.width;
//        CGFloat height = image.size.height;
        CGFloat width = 16;
        CGFloat height = 16;
        
        width = width > self.height ? width : self.height;
        height = height > self.height ? height : self.height;
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:(CGRect){self.width - width - 10, (self.height - height) / 2, width, height}];
        [closeButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeNoticeView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeButton];
        
    }
}

- (void)closeNoticeView:(id)sender
{
    if (self.CloseNoticeViewBlock) {
        self.CloseNoticeViewBlock();
    }
}

@end
