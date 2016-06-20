//
//  LocusVM.m
//  KinGuard
//
//  Created by RuanSTao on 16/6/20.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "LocusVM.h"
#import "DeviceInfo.h"

@interface LocusVM ()

@property (nonatomic,assign) NSInteger requestPidIndex;

@property (nonatomic,strong) NSArray *pids;

@property (nonatomic,strong) NSMutableArray *array;

@property (nonatomic,copy) CompletionWithObjectBlock block;

@end

@implementation LocusVM


- (void)requestDeviceInfoWithPid:(NSArray *)pids complete:(CompletionWithObjectBlock)block
{
    self.requestPidIndex = 0;
    self.pids = pids;
    self.block = block;
    self.array = [NSMutableArray array];
    if (pids.count == 0) {
        block(NO,nil);
    }
    [self requestDeviceInfoWithPid:pids[self.requestPidIndex]];
}

- (void)requestDeviceInfoWithPid:(NSString *)pid
{
    if (pid) {
        __weak typeof(self) weakSelf = self;
        [self requestDeviceInfo:pid finish:^(DeviceInfo *info) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (info.asset_name == nil || info.asset_name.length ==0) {
                info.asset_name = @"宝贝";
            }
            [strongSelf.array addObject:info];
            strongSelf.requestPidIndex ++;
            if (strongSelf.requestPidIndex < strongSelf.pids.count) {
                [strongSelf requestDeviceInfoWithPid:strongSelf.pids[strongSelf.requestPidIndex]];
            }else{
                [strongSelf requestDeviceInfoWithPid:nil];
            }

        }];

    }else{
        if (self.block) {
            self.block(YES,self.array);
        }
    }
}

- (void)requestDeviceInfo:(NSString *)pid finish:(void (^)(DeviceInfo *info))block
{
    [[KinDeviceApi sharedKinDevice] deviceInfoPid:pid success:^(NSDictionary *data) {
        NSLog(@"info:%@",data);
        if (block) {
            block([DeviceInfo mj_objectWithKeyValues:data]);
        }
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
