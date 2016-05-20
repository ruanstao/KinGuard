//
//  SafeZoneModel.h
//  KinGuard
//
//  Created by Rainer on 16/5/18.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafeZoneModel : NSObject

@property(nonatomic, copy) NSString *addr;
@property(nonatomic, copy) NSString *alias;
@property(nonatomic, copy) NSString *asset_id;
@property(nonatomic, copy) NSString *days;
@property(nonatomic, copy) NSString *in_timestamp;
@property(nonatomic, copy) NSString *latitude;
@property(nonatomic, copy) NSString *longitude;
@property(nonatomic, copy) NSString *out_timestamp;
@property(nonatomic, copy) NSString *radius;
@property(nonatomic, copy) NSString *token;

@end
