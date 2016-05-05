//
//  LeftViewController.h
//  KinGuard
//
//  Created by RuanSTao on 16/4/28.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, LeftType) {
    LeftType_JianKongLog = 1 ,
    LeftType_JianKongMember,
    LeftType_AddDevice,
    LeftType_Setting,
    LeftType_Login
};
@interface LeftViewController : KinViewController

+ (instancetype)creatByNib;

@end
