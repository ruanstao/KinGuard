//
//  LocusVM.h
//  KinGuard
//
//  Created by RuanSTao on 16/6/20.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocusVM : NSObject

- (void)requestDeviceInfoWithPid:(NSArray *)pids complete:(CompletionWithObjectBlock)block;

@end
