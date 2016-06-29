//
//  LocationHistroyModel.h
//  KinGuard
//
//  Created by Rainer on 16/6/29.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationHistroyModel : NSObject
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *fromname;
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *battery;
@property (nonatomic, copy) NSString *location_m;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *range;
@end
