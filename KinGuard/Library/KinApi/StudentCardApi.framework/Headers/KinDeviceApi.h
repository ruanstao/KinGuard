//
//  KinDeviceApi.h
//  StudentCardApi
//
//  Created by Rainer on 16/4/3.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefines.h"

@interface KinDeviceApi : NSObject

+ (KinDeviceApi *)sharedKinDevice;

#pragma mark - 设备绑定
//通过二维码绑定
- (void)bindDeviceByQRCode:(NSString *)qrcode success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//通过设备id绑定
- (void)bindDeviceByPid:(NSString *)pid withKey:(NSString *)akey success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//关注号绑定(二维码)
- (void)bindFollowByQRCode:(NSString *)qrcode withSmscode:(NSString *)smscode success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//关注号绑定(设备 ID 号)
- (void)bindFollowByPid:(NSString *)pid withKey:(NSString *)akey withSmscode:(NSString *)smscode success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//设备解绑(通过 ID 号)
- (void)unBindDeviceByPid:(NSString *)pid withKey:(NSString *)akey withMainacc:(NSString *)mainacc success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//设备解绑(通过二维码)
- (void)unBindDeviceByQrcode:(NSString *)qrcode withMainacc:(NSString *)mainacc success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 关系设定
//关系设定
- (void)setRelationshipWithPid:(NSString *)pid withRelationship:(NSString *)relationship success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 宝贝信息

//宝贝列表
- (void)deviceListSuccess:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//宝贝信息
- (void)deviceInfoPid:(NSString *)pid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//修改宝贝信息
- (void)updateDeviceInfoPid:(NSString *)pid withAssetname:(NSString *)asset_name withSex:(NSString *)sex success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//监护人绑定信息
- (void)deviceBindInfoPid:(NSString *)pid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//记步数
- (void)startStepsPid:(NSString *)pid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 绑定推送
//绑定百度推送
- (void)bindBaiduPushWithUserid:(NSString *)userid withChannelid:(NSString *)channelid withAppid:(NSString *)appid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

//绑定极光推送
- (void)bindJpushWithRegisterid:(NSString *)registerid success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

@end
