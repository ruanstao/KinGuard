//
//  DeviceInfo.h
//  KinGuard
//
//  Created by RuanSTao on 16/5/9.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject
@property (nonatomic,strong) NSString *akey;
@property (nonatomic,strong) NSString *asset_id;
@property (nonatomic,strong) NSString *asset_name;
@property (nonatomic,strong) NSString *qrcode;
@property (nonatomic,strong) NSString *qsc_ver;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *wifi_ver;

//akey = 6ce68d05;
//"asset_id" = c202237b;
//"asset_name" = hellO;
//qrcode = 042bd75cb0bf4cdcad4d77038baec47e3ec5;
//"qsc_ver" = "1.2.19";
//sex = F;
//"wifi_ver" = "1.3.0";
@end
