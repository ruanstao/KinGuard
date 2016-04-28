//
//  JJSShareView.m
//  JJSMOA
//
//  Created by JJSAdmin on 15/6/30.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSShareView.h"

@implementation JJSShareView
{
    UIView *overlay;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, mScreenHeight, mScreenWidth, (326+14+92)/2)];
    if (self) {
        self.opaque = NO;
        self.alpha = 1.0;
        self.backgroundColor = HexRGB(0xe1e9f0);
        
        UIView *wbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 326/2)];
        wbView.backgroundColor = HexRGB(0xffffff);
        [self addSubview:wbView];
        
        UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(66/2, 39/2, 160/2, 27/2)];
        lbl1.backgroundColor = [UIColor clearColor];
        lbl1.text = @"分享到 :";
        lbl1.font = kContentFontMiddle;
        lbl1.textAlignment = NSTextAlignmentLeft;
        lbl1.textColor = HexRGB(0x2c3e50);
        [wbView addSubview:lbl1];
        
        //微信
        UIImage *wImage = mImageByName(@"share_wechat");
        UIButton *weixinButton = [[UIButton alloc] initWithFrame:CGRectMake(66/2, CGRectGetMaxY(lbl1.frame)+48/2, wImage.size.width, wImage.size.height)];
        weixinButton.backgroundColor = [UIColor clearColor];
        [weixinButton setImage:wImage forState:0];
        [weixinButton addTarget:self action:@selector(weixinButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [wbView addSubview:weixinButton];
        
        //QQ
        UIImage *qImage = mImageByName(@"share_qq");
        UIButton *qqButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weixinButton.frame)+66/2, CGRectGetMaxY(lbl1.frame)+48/2, qImage.size.width, qImage.size.height)];
        qqButton.backgroundColor = [UIColor clearColor];
        [qqButton setImage:qImage forState:0];
        [qqButton addTarget:self action:@selector(qqButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [wbView addSubview:qqButton];
        
        //短信
        UIImage *mImage = mImageByName(@"mail");
        UIButton *messageButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(qqButton.frame)+66/2, CGRectGetMaxY(lbl1.frame)+48/2, mImage.size.width, mImage.size.height)];
        messageButton.backgroundColor = [UIColor clearColor];
        [messageButton setImage:mImage forState:0];
        [messageButton addTarget:self action:@selector(messageButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [wbView addSubview:messageButton];
        
        UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(weixinButton.frame), CGRectGetMaxY(weixinButton.frame)+10, CGRectGetWidth(weixinButton.frame), 23/2)];
        lbl2.backgroundColor = [UIColor clearColor];
        lbl2.text = @"微信好友";
        lbl2.font = kContentFontSmall;
        lbl2.textAlignment = NSTextAlignmentCenter;
        lbl2.textColor = HexRGB(0x2c3e50);
        [wbView addSubview:lbl2];
        
        UILabel *lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(qqButton.frame), CGRectGetMaxY(qqButton.frame)+10, CGRectGetWidth(qqButton.frame), 23/2)];
        lbl3.backgroundColor = [UIColor clearColor];
        lbl3.text = @"QQ好友";
        lbl3.font = kContentFontSmall;
        lbl3.textAlignment = NSTextAlignmentCenter;
        lbl3.textColor = HexRGB(0x2c3e50);
        [wbView addSubview:lbl3];
        
        UILabel *lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(messageButton.frame), CGRectGetMaxY(messageButton.frame)+10, CGRectGetWidth(messageButton.frame), 23/2)];
        lbl4.backgroundColor = [UIColor clearColor];
        lbl4.text = @"短信";
        lbl4.font = kContentFontSmall;
        lbl4.textAlignment = NSTextAlignmentCenter;
        lbl4.textColor = HexRGB(0x2c3e50);
        [wbView addSubview:lbl4];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(wbView.frame)+7, mScreenWidth, CGRectGetHeight(self.frame)-(CGRectGetMaxY(wbView.frame)+7))];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton setBackgroundImage:mImageByName(@"nav_bg_ios6") forState:0];
        [cancelButton setTitle:@"取消" forState:0];
        [cancelButton setTitleColor:HexRGB(0x2c3e50) forState:0];
        cancelButton.titleLabel.font = kTitleFontSec;
        [cancelButton addTarget:self action:@selector(overTapGesture) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
    }
    return self;
}

//微信分享事件
- (void)weixinButtonAction
{
    if (self.block) {
        self.block(SHARE_WEIXIN);
    }
    [self animateShow:NO completionBlock:nil];
}

//QQ分享事件
- (void)qqButtonAction
{
    if (self.block) {
        self.block(SHARE_QQ);
    }
    [self animateShow:NO completionBlock:nil];
}

- (void)messageButtonAction
{
    if (self.block) {
        self.block(SHARE_MESSAGE);
    }
    [self animateShow:NO completionBlock:nil];
}

- (void)animateShow:(BOOL)show completionBlock:(JJSShareViewBlock)completion;
{
    if (completion)
    {
        self.block = completion;
    }
    
    __weak typeof(self) weakSelf = self;
    if (show) {
        [self showOverlay:YES];
        
        [UIView animateWithDuration:.2 animations:^{
            CGRect rect = weakSelf.frame;
            rect.origin.y = mScreenHeight - (326+14+92)/2;
            weakSelf.frame = rect;
        } completion:^(BOOL finished) {
        }];
    }else{
        [self showOverlay:NO];
        
        [UIView animateWithDuration:.2 animations:^{
            CGRect rect = weakSelf.frame;
            rect.origin.y = mScreenHeight;
            weakSelf.frame = rect;
        } completion:^(BOOL finished) {
            [weakSelf cleanup];
        }];
    }
}

- (void)showOverlay:(BOOL)show {
    if (show) {
        // create a new window to add our overlay and dialogs to
        UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window = window;
        window.windowLevel = UIWindowLevelStatusBar + 1;
        window.opaque = NO;
        
        // darkened background
        overlay = [UIView new];
        overlay.opaque = NO;
        overlay.frame = self.window.bounds;
        overlay.backgroundColor = [UIColor colorWithWhite:0.22 alpha:0.5];
        
        //添加点击事件
        UITapGestureRecognizer *overTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(overTapGesture)];
        [overlay addGestureRecognizer:overTap];
        
        [self.window addSubview:overlay];
        [self.window addSubview:self];
        
        // window has to be un-hidden on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.window makeKeyAndVisible];
            
            // fade in overlay
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                //self.blurredBackgroundView.alpha = 1.0f;
                overlay.alpha = 1.0f;
            } completion:^(BOOL finished) {
                // stub
            }];
        });
    }
    else {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            overlay.alpha = 0.0f;
            //self.blurredBackground.alpha = 0.0f;
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)overTapGesture
{
    [self animateShow:NO completionBlock:nil];
}

- (void)cleanup {
    //self.layer.transform = CATransform3DIdentity;
    //self.transform = CGAffineTransformIdentity;
    self.alpha = 1.0f;
    self.window = nil;
    // rekey main AppDelegate window
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
}

- (void)dealloc{
//    NSLog();
}

@end
