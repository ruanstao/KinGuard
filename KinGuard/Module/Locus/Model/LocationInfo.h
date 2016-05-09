//
//  LocationInfo.h
//  KinGuard
//
//  Created by RuanSTao on 16/5/9.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationInfo : NSObject

@property (nonatomic,strong) NSString *addr;
@property (nonatomic,assign) NSInteger battery;
@property (nonatomic,strong) NSString *cmd;
@property (nonatomic,assign) NSInteger from;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;
@property (nonatomic,assign) NSInteger range;
@property (nonatomic,assign) long long timestamp;
@property (nonatomic,assign) NSInteger token;
@property (nonatomic,assign) NSInteger value;

//addr = "观日路观日路四美达科技";
//battery = 2;
//cmd = "";
//from = 3;
//latitude = "24.4863862";
//longitude = "118.1823576";
//range = 51;
//timestamp = 1462788906;
//token = 433826;
//value = 0;
@end
