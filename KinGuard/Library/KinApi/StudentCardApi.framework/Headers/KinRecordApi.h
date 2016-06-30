//
//  KinRecordApi.h
//  StudentCardApi
//
//  Created by Rainer on 16/4/4.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefines.h"

//录音
@interface KinRecordApi : NSObject

+ (KinRecordApi *)sharedKinRecordApi;

/**
 *  监听申请
 */
- (void)applicationMonitorWithDeviceId:(NSString *)deviceId andFinished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;
/**
 *  录音信息
 */
- (void)recordInfomationWithDeviceId:(NSString *)deviceId andFinished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

/**
 *  录音下载
 *  fileName 为下载后文件的名字，带后缀，可不填
 */
- (void)downloadRecordWithDeviceId:(NSString *)deviceId token:(NSString *)token
                       andFileName:(NSString *)fileName andProgress:(KSDownloadProgress)progress finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

//上传聊天信息
- (void)uploadChatMessageToAcc:(NSString *)acc chatContent:(NSString *)message finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

//获取聊天信息
- (void)getMessageToAcc:(NSString *)acc fromDate:(NSString *)fromDate toDate:(NSString *)toDate finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

//群聊信息上传
- (void)uploadMessageToPid:(NSString *)pid chatContent:(NSString *)chatcontent finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

//获取群聊信息
- (void)getChatMessage:(NSString *)pid chatContent:(NSString *)chatcontent fromDate:(NSString *)fromDate toDate:(NSString *)toDate finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

@end
