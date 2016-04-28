//
//  JJSTableViewController.h
//  JJSOA
//
//  Created by 邱弘宇 on 16/1/15.
//  Copyright © 2016年 JJSHome. All rights reserved.
//
/**
 *  Description: Base table view controller
 */
#import <UIKit/UIKit.h>

@interface JJSTableViewController : UITableViewController
// iOS7中，放置于状态栏后(default is hide)
@property (nonatomic , strong) UIView *statusBar;
@property (nonatomic , strong, readonly) UIButton *backBtn;

- (UIView *)errorViewshowTopView:(BOOL)show;
- (UIView *)loadingView;
- (UIView *)alphaBackgroundView;
- (UIView *)noNetworkViewshowTopView:(BOOL)show;

- (void)showLoadingAnimated:(BOOL)animated;
- (void)hideLoadingViewAnimated:(BOOL)animated;

- (void)showErrorViewAnimated:(BOOL) animated andShowTop:(BOOL) show;
- (void)hideErrorViewAnimated:(BOOL) animated andShowTop:(BOOL) show;

- (void)showAlphaBackgroundView:(BOOL)animated;
- (void)hideAlphaBackgroundView:(BOOL)animated;

- (void)showNoNetworkView:(BOOL)animated andShowTop:(BOOL) show;
- (void)hideNoNetworkView:(BOOL)animated andShowTop:(BOOL) show;

- (void)showServerErrorView:(BOOL)animated andShowTop:(BOOL) show;
- (void)hideServerErrorView:(BOOL)animated andShowTop:(BOOL) show;

//刷新
- (void)tryReload:(id)sender;

// 用作统计用（Google、百度或者友盟等）
- (void)startTracking;

@end
