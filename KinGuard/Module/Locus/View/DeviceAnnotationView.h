//
//  DeviceAnnotationView.h
//  KinGuard
//
//  Created by RuanSTao on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "LocationInfo.h"
#import "DeviceInfoView.h"

@interface DeviceAnnotationView : MAAnnotationView

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) UIImage *portrait;

@property (nonatomic, strong) DeviceInfoView *calloutView;
@property (nonatomic, strong) LocationInfo *locationInfo;

@property (nonatomic, assign) BOOL animation;
@end
