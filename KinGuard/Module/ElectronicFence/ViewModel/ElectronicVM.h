//
//  ElectronicVM.h
//  KinGuard
//
//  Created by Rainer on 16/5/24.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SafeZoneModel.h"

@interface ElectronicVM : NSObject

+ (NSMutableArray *)fitterDataWith:(SafeZoneModel *)model;

@end
