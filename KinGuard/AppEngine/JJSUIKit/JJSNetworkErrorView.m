//
//  JJSNetworkErrorView.m
//  JJSOA
//
//  Created by YD-Guozuhong on 16/3/25.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSNetworkErrorView.h"

@implementation JJSNetworkErrorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)configureNetworkErrorViewWithTitle:(NSString *)title imageName:(NSString *)name
{
    
    UIImageView *noNetworkView = [[UIImageView alloc] init];
    [noNetworkView setFrame:CGRectMake(((self.width / 2 - 78 ) / 2), (self.height - 58 - 18 - 20) / 2 - 60, 78, 58)];
    [noNetworkView setImage:[UIImage imageNamed:name ? : @"no_network"]];
    [self addSubview:noNetworkView];
    
    UILabel *labNoNetwork = [[UILabel alloc] init];
    [labNoNetwork setFrame:CGRectMake(0, noNetworkView.frame.origin.y + 81 + 20, self.width, 18)];
    [labNoNetwork setText:title ? : @"亲，您的网络不太顺畅哦~"];
    [labNoNetwork setFont:kTitleFontSec];
    [labNoNetwork setTextAlignment:NSTextAlignmentCenter];
    [labNoNetwork setTextColor:kTableViewCellDetailLabelTextColor];
    [self addSubview:labNoNetwork];
    
    UIButton *btnReload = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnReload setFrame:CGRectMake((self.width - 84) / 2, labNoNetwork.frame.origin.y + 18 + 20, 84, 28)];
    [btnReload setTitle:@"重新加载" forState:UIControlStateNormal];
    [btnReload setTitleColor:HexRGB(0x666666) forState:UIControlStateNormal];
    [btnReload setTitleColor:HexRGB(0x999999) forState:UIControlStateHighlighted];
    [btnReload.titleLabel setFont:kContentFontMiddle];
    [btnReload setBackgroundColor:[UIColor colorWithRed:0.980 green:0.980 blue:0.980 alpha:1]];
    [btnReload.layer setBorderColor:HexRGB(0xb8b8b8).CGColor];
    [btnReload.layer setBorderWidth:1];
    [btnReload.layer setCornerRadius:4];
    [btnReload.layer setMasksToBounds:YES];
    [btnReload addTarget:self action:@selector(tryReload:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnReload];
    
}

- (void)tryReload:(id)sender
{
    if (self.TryReloadAction) {
        self.TryReloadAction();
    }
}

@end
