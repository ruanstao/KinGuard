//
//  KinLocationApi.h
//  StudentCardApi
//
//  Created by Rainer on 16/4/4.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefines.h"

//定位
@interface KinLocationApi : NSObject

+ (KinLocationApi *)sharedKinLocation;

#pragma mark - 普通定位申请
- (void)startNormalLocation:(NSString *)pid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 紧急定位申请
- (void)startUrgenLocation:(NSString *)pid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 监听申请
- (void)startRecordLocation:(NSString *)pid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 获取定位信息
- (void)readLocationInfo:(NSString *)pid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 获取历史定位信息
- (void)readPosHisInfo:(NSString *)pid withBegdt:(NSString *)beginTime withEnddt:(NSString *)endTime success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 根据token值获取定位信息
- (void)getLocationByPid:(NSString *)pid withLocationToken:(NSString *)token success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 设定安全区域
- (void)setSecZone:(NSString *)pid withAction:(NSString *)action withAddr:(NSString *)addr withLng:(NSString *)lng withLat:(NSString *)lat withIntime:(NSString *)intime withOuttime:(NSString *)outtime withDays:(NSString *)days withRadius:(NSString *)radius withTokenno:(NSString *)tokenno success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 获取安全区域列表
- (void)getSecZonePid:(NSString *)pid  success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

@end
