//
//  KinGuardDefine.h
//  KinGuard
//
//  Created by Rainer on 16/5/6.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#ifndef KinGuardDefine_h
#define KinGuardDefine_h

typedef NS_ENUM(NSInteger, XDScaningViewCoverMode) {
    XDScaningViewCoverModeClear,
    XDScaningViewCoverModeNormal, //默认
    XDScaningViewCoverModeBlur,
};

typedef NS_ENUM(NSInteger, XDScaningViewShapeMode) {
    XDScaningViewShapeModeSquare, //默认
    XDScaningViewShapeModeRound,
    
};

typedef NS_ENUM(NSInteger, XDScaningLineMoveMode) {
    XDScaningLineMoveModeDown, //默认
    XDScaningLineMoveModeUpAndDown,
    XDScaningLineMoveModeNone,
    
};

typedef NS_ENUM(NSInteger, XDScaningLineMode) {
    XDScaningLineModeNone, //什么都没有
    XDScaningLineModeDeafult, //默认
    XDScaningLineModeImge,  //以一个图为扫描线，微信，百度
    XDScaningLineModeGrid, //类似京东
};

typedef NS_ENUM(NSInteger, XDScaningWarningTone) {
    XDScaningWarningToneSound, //声音
    XDScaningWarningToneVibrate, //震动
    XDScaningWarningToneSoundAndVibrate, //声音和振动
};

#define Main_Color [UIColor colorWithRed:0/255.0 green:124/255.0 blue:194/255.0 alpha:1]
#define Main_BG_Color [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]

#define ButtonSize CGSizeMake(40,40) //扫描界面所有触发事件的按钮的大小
#define ButtonFromBottom 80 // 屏幕下面的按钮到屏幕底部的距离

#define Iphone4 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480))?YES:NO
#define Iphone5 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))?YES:NO
#define Iphone6 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667))?YES:NO
#define Iphone6AndsPlus CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736))?YES:NO
#define ScreenSize [UIScreen mainScreen].bounds.size
#define Color(r,g,b,a)  [UIColor colorWithRed:r/225.0 green:g/225.0 blue:b/225.9 alpha:a]

/*
 此处是配置扫描秒区域适配各种屏幕的大小
 介于iPhone4和iPhone5的屏幕宽度一样，所以就归为一类
 猿类们可以根据自己项目的要求设置在不同屏幕中显示的大小
 不管怎么调整扫描区域在屏幕的位置始终是居中， 如果不想剧中则自行改代码去吧
 */
#define Iphone45ScanningSize_width 160
#define Iphone45ScanningSize_height 240
#define Iphone6ScanningSize_width 180
#define Iphone6ScanningSize_height 270
#define Iphone6PlusScanningSize_width 200
#define Iphone6PlusScanningSize_height 300
#define TransparentArea(a,b)  CGSizeMake(a, b)

#define LineColor Color(94,121,70,.2) //扫描线的颜色，RGBA,用户可以定义任何颜色
#define LineShadowLastInterval .1 //此属性决定扫描线后面的尾巴的长短，值越大越长，当然XDScaningLineMode必须为XDScaningLineDeafult，其他无效
#define LineMoveSpeed 1 //扫描线移动的速度，值为每1/60秒移动的点数，数值越大移动速度越快

#define KinGuard_UserInfo @"user_info"
#define KinGuard_Device @"device_pids"
#define CurrentBaby_Info @"baby_info"
#define PosHis_Line @"PosHis_Line"

#endif /* KinGuardDefine_h */
