//
//  JJSViewController.m
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSViewController.h"
#import "TransparentView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#define TAG_VIEW_TRANSPARENT_BACKGROUND  80150288
#define TAG_VIEW_TRANSPARENT_NO_DATAVIEW 80150289
#define TAG_VIEW_TRANSPARENT_NO_NETWORK  80150290
#define TAG_VIEW_TRANSPARENT_SERVER_ERROR 80150291

@interface JJSViewController ()
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIView *errorView;
@property (strong, nonatomic) UIView *noNetWorkView;
@end

@implementation JJSViewController

#pragma mark -
#pragma mark Life view cycle
- (instancetype) init
{
    self = [super init];
    if (self) {
        NSLog(@"%@ init",[self class]);
    }
    return self;
}
- (void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
        
    }
    
    self.view.backgroundColor = kAppBgColor;
//    self.navigationController.view.radius = 3;
//    self.navigationController.navigationBar setTranslucent:NO];
    
    self.statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    self.statusBar.backgroundColor = [kAppBgColor colorWithAlphaComponent:0.95];
    self.statusBar.hidden = YES;
    [self.view addSubview:self.statusBar];
    
    if (self.navigationController.viewControllers.count > 1)
    {
        [self showBackButton:YES];
    }

    if ([self isNeedNavBarSeparatorLine]) {
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
            NSArray *list=self.navigationController.navigationBar.subviews;
            for (id obj in list) {
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_border"]];
                            float top = imageView2.top > 44 ? imageView2.top - 0.5 : 64 - 0.5;
                            [customView setFrame:(CGRect){imageView2.left,top,imageView2.width,1}];
                            [imageView2.superview addSubview:customView];
                            [customView bringSubviewToFront:imageView2];
                            imageView2.hidden=YES;
                            break;
                        }
                    }
                }
            }
        }
    }
    
}
//供子类选择，默认添加
- (BOOL)isNeedNavBarSeparatorLine
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
    [self.view bringSubviewToFront:self.statusBar];
    [self.backBtn setTitle:[self lastViewControllerTitle] forState:UIControlStateNormal];

}

- (void)showBackButton:(BOOL)show
{
    if (!show)
    {
        return;
    }
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 55, 40);
    if (mIsIOS7OrLater)
    {
        self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 6, 7, 25);
        self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    }
    else
    {
        self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 10, 7, 20);
        self.backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    self.backBtn.contentHorizontalAlignment = UIViewContentModeLeft;
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    // Replace backItem with real back button image
    [self.backBtn setImage:mImageByName(@"backMenu") forState:UIControlStateNormal];
    [self.backBtn setTitleColor:kBtnTitleNormalColor forState:UIControlStateNormal];
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:0];
    self.backBtn.titleLabel.adjustsFontSizeToFitWidth = YES;

    [self.backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn.showsTouchWhenHighlighted = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
}

//供子类修改返回类型
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)removeShadowFromNavigationBar
//{
//    // Remove shadow of UINavigationBar
//    for (UIView *view in self.navigationController.navigationBar.subviews)
//    {
//        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
//        {
//            for (CALayer *layer in view.layer.sublayers)
//            {
//                layer.hidden = YES;
//            }
//        }
//    }
//}

- (NSString *)lastViewControllerTitle
{
    if (self.navigationController.viewControllers.count > 1)
    {
        NSInteger lastVCIdx = 0;
        for (int i = 0; i < self.navigationController.viewControllers.count; i++)
        {
            UIViewController *vc = self.navigationController.viewControllers[i];
            if ([vc isKindOfClass:[self class]])
            {
                lastVCIdx = i - 1;
                break;
            }
        }
        
        JJSViewController *lastVC = self.navigationController.viewControllers[lastVCIdx];
        return lastVC.title;
    }
    
    return @"返回";
}



- (UIView *)errorViewshowTopView:(BOOL)show
{
    TransparentView *view = [[TransparentView alloc] init];
    if (show) {
        [view setFrame:CGRectMake(0, 104, mScreenWidth, mScreenHeight - 104)];
    }else{
        [view setFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 64)];
    }
    
    [view setTag:TAG_VIEW_TRANSPARENT_NO_DATAVIEW];
    
    UIImageView *noDataView = [[UIImageView alloc] init];
    [noDataView setFrame:CGRectMake((view.frame.size.width/2 - 66/2), (view.frame.size.height - 81 - 20 - 18)/2 - 40, 66, 81)];
    [noDataView setImage:[UIImage imageNamed:@"no_date"]];
    [view addSubview:noDataView];
    
    UILabel *labNoData = [[UILabel alloc] init];
    [labNoData setFrame:CGRectMake(0, noDataView.frame.origin.y + 81 + 20, view.frame.size.width, 18)];
    [labNoData setText:@"亲，暂无数据哦~"];
    [labNoData setTextAlignment:NSTextAlignmentCenter];
    [labNoData setFont:kTitleFontSec];
    [labNoData setTextColor:kTableViewCellDetailLabelTextColor];
    [view addSubview:labNoData];
    
    return view;
}

- (UIView *)noNetworkViewshowTopView:(BOOL)show
{
    UIView *view = [[UIView alloc] init];
    if (show) {
        [view setFrame:CGRectMake(0, 104, mScreenWidth, mScreenHeight - 104)];
    }else{
        [view setFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 64)];
    }
    
    [view setTag:TAG_VIEW_TRANSPARENT_NO_NETWORK];
    
    UIImageView *noNetworkView = [[UIImageView alloc] init];
    [noNetworkView setFrame:CGRectMake((view.frame.size.width/2 - 78/2), (view.frame.size.height - 58 - 18 - 20)/2 - 60, 78, 58)];
    [noNetworkView setImage:[UIImage imageNamed:@"no_network"]];
    [view addSubview:noNetworkView];
    
    UILabel *labNoNetwork = [[UILabel alloc] init];
    [labNoNetwork setFrame:CGRectMake(0, noNetworkView.frame.origin.y + 81 + 20, view.frame.size.width, 18)];
    [labNoNetwork setText:@"亲，您的网络不太顺畅哦~"];
    [labNoNetwork setFont:kTitleFontSec];
    [labNoNetwork setTextAlignment:NSTextAlignmentCenter];
    [labNoNetwork setTextColor:kTableViewCellDetailLabelTextColor];
    [view addSubview:labNoNetwork];
    
    UIButton *btnReload = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnReload setFrame:CGRectMake((view.frame.size.width - 84) / 2, labNoNetwork.frame.origin.y + 18 + 20, 84, 28)];
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
    [view addSubview:btnReload];
    
    return view;
}

- (UIView *)serverErrorViewshowTopView:(BOOL)show
{
    UIView *view = [[UIView alloc] init];
    if (show) {
        [view setFrame:CGRectMake(0, 104, mScreenWidth, mScreenHeight - 104)];
    }else{
        [view setFrame:CGRectMake(0, 64, mScreenWidth, mScreenHeight - 64)];
    }
    
    [view setTag:TAG_VIEW_TRANSPARENT_SERVER_ERROR];
    
    UIImageView *noNetworkView = [[UIImageView alloc] init];
    [noNetworkView setFrame:CGRectMake((view.frame.size.width/2 - 66/2), (view.frame.size.height - 81 - 18 - 20)/2 - 60, 66, 81)];
    [noNetworkView setImage:[UIImage imageNamed:@"no_date"]];
    [view addSubview:noNetworkView];
    
    UILabel *labNoNetwork = [[UILabel alloc] init];
    [labNoNetwork setFrame:CGRectMake(0, noNetworkView.frame.origin.y + 81 + 20, view.frame.size.width, 18)];
    [labNoNetwork setText:@"亲，攻城狮正在紧张修复中^_^"];
    [labNoNetwork setFont:kTitleFontSec];
    [labNoNetwork setTextAlignment:NSTextAlignmentCenter];
    [labNoNetwork setTextColor:kTableViewCellDetailLabelTextColor];
    [view addSubview:labNoNetwork];
    
    UIButton *btnReload = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnReload setFrame:CGRectMake((view.frame.size.width - 84) / 2, labNoNetwork.frame.origin.y + 18 + 20, 84, 28)];
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
    [view addSubview:btnReload];
    
    return view;
}

- (UIView *)loadingView
{
    return nil;
}

- (UIView *)alphaBackgroundView
{

    UIView *view;
    if ([self.navigationController.view viewWithTag:TAG_VIEW_TRANSPARENT_BACKGROUND]) {
        
        view = [self.navigationController.view viewWithTag:TAG_VIEW_TRANSPARENT_BACKGROUND];
        
    } else if ([self.view viewWithTag:TAG_VIEW_TRANSPARENT_BACKGROUND]) {
        
        view = [self.view viewWithTag:TAG_VIEW_TRANSPARENT_BACKGROUND];
        
    } else {
    
        view = [[UIView alloc] initWithFrame:(CGRect){0, 0, mScreenWidth, mScreenHeight}];
        [view setBackgroundColor:[UIColor blackColor]];
        [view setTag:TAG_VIEW_TRANSPARENT_BACKGROUND];
        
    }
    return view;
    
}

- (void)showLoadingAnimated:(BOOL) animated
{
    UIView *loadingView = [self loadingView];
    loadingView.alpha = 0.0f;
    [self.view addSubview:loadingView];
    [self.view bringSubviewToFront:loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration
                     animations:^
     {
         loadingView.alpha = 1.0f;
     }];
}

- (void)hideLoadingViewAnimated:(BOOL) animated
{
    UIView *loadingView = [self loadingView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration
                     animations:^
     {
         loadingView.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         [loadingView removeFromSuperview];
     }];
}
#pragma mark - 无数据界面
- (void)showErrorViewAnimated:(BOOL) animated andShowTop:(BOOL) show
{
    if (nil == _errorView) {
        _errorView = [self errorViewshowTopView:show];
        _errorView.alpha = 0.0f;
        [self.view addSubview:_errorView];
    }
       if (show) {
            [self.view bringSubviewToFront:_errorView];
            double duration = animated ? 0.4f:0.0f;
            [UIView animateWithDuration:duration
                             animations:^
             {
                 _errorView.alpha = 1.0f;
             }];
        }else{
            [self.view sendSubviewToBack:_errorView];
        }
    }

- (void)hideErrorViewAnimated:(BOOL) animated andShowTop:(BOOL) show
{
//    UIView *errorView = mViewByTag(self.view, TAG_VIEW_TRANSPARENT_NO_DATAVIEW, UIView);
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^
     {
         _errorView.alpha = 0.0f;
     }
      completion:^(BOOL finished)
     {
         [_errorView removeFromSuperview];
         _errorView = nil;
     }];
}
#pragma mark - 背景界面
- (void)showAlphaBackgroundView:(BOOL)animated
{

    [self.navigationController.fd_fullscreenPopGestureRecognizer setEnabled:NO];
    UIView *alphaBgView = [self alphaBackgroundView];
    alphaBgView.alpha = 0.0f;
    
    UIView *parentView = self.navigationController.view ? : self.view;
    [parentView addSubview:alphaBgView];
    [parentView bringSubviewToFront:alphaBgView];
    float duration = animated ? 0.6f : 0.0f;
    [UIView animateWithDuration:duration animations:^{
        
        alphaBgView.alpha = 0.6f;
        
    }];
    
}

- (void)hideAlphaBackgroundView:(BOOL)animated
{

    UIView *alphaBgView = [self alphaBackgroundView];
    double duration = animated ? 0.6f:0.0f;
    [UIView animateWithDuration:duration animations:^
     {
         
         alphaBgView.alpha = 0.0f;
         
     } completion:^(BOOL finished) {
         
         [alphaBgView removeFromSuperview];
         [self.navigationController.fd_fullscreenPopGestureRecognizer setEnabled:YES];
         
     }];
    
}
#pragma mark - 无网络界面
- (void)showNoNetworkView:(BOOL)animated andShowTop:(BOOL) show
{
    if (nil == self.noNetWorkView) {
        self.noNetWorkView = [self noNetworkViewshowTopView:show];
        self.noNetWorkView.alpha = 0;
         [self.view addSubview:self.noNetWorkView];
    }
    if (show) {
        [self.view bringSubviewToFront:self.noNetWorkView];
        double duration = animated ? 0.4f:0.0f;
        [UIView animateWithDuration:duration
                         animations:^
         {
             self.noNetWorkView.alpha = 1.0f;
         }];
    }else{
         [self.view sendSubviewToBack:self.noNetWorkView];
    }
    

}

- (void)hideNoNetworkView:(BOOL)animated andShowTop:(BOOL) show
{
//    UIView *errorView = mViewByTag(self.view, TAG_VIEW_TRANSPARENT_NO_NETWORK, UIView);;
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^
     {
         self.noNetWorkView.alpha = 0.0f;
     } completion:^(BOOL finished) {
         
         [self.noNetWorkView removeFromSuperview];
     }];
}

- (void)tryReload:(id)sender
{

}

#pragma mark - 服务器异常界面
//亲，攻城狮正在紧张修复中^_^
- (void)showServerErrorView:(BOOL)animated andShowTop:(BOOL) show
{
    UIView *errorView = [self serverErrorViewshowTopView:show];
    errorView.alpha = 0.0f;
    [self.view addSubview:errorView];
    [self.view bringSubviewToFront:errorView];
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration
                     animations:^
     {
         errorView.alpha = 1.0f;
     }];
}

- (void)hideServerErrorView:(BOOL)animated andShowTop:(BOOL) show
{
    UIView *errorView = mViewByTag(self.view, TAG_VIEW_TRANSPARENT_SERVER_ERROR, UIView);;
    
    double duration = animated ? 0.4f:0.0f;
    [UIView animateWithDuration:duration animations:^
     {
         errorView.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         [errorView removeFromSuperview];
     }];
}

- (void)startTracking
{

}


@end
