//
//  DeviceInfoView.h
//  KinGuard
//
//  Created by RuanSTao on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationInfo.h"

@interface DeviceInfoView : UIView

+ (instancetype)creatByNib;

- (void)initWithLocationModel:(LocationInfo *)info;

@end
