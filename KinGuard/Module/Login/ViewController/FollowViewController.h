//
//  FollowViewController.h
//  KinGuard
//
//  Created by Rainer on 16/5/10.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "KinViewController.h"
typedef enum: NSInteger{

    BindType_QRCode = 0,
    BindType_Pid = 1
}BindType;
@interface FollowViewController : KinViewController

@property(nonatomic, assign) BindType type;

@property (nonatomic, copy) NSString *qrcode;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *akey;

@end
