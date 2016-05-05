//
//  KinFileApi.h
//  StudentCardApi
//
//  Created by Rainer on 16/4/4.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefines.h"

//文件上传下载
@interface KinFileApi : NSObject

+ (KinFileApi *)sharedKinFileApi;

/**
 *  文件清单
 */
- (void)requestFileListFinished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

/**
 *  文件上传
 */
- (void)uploadFileWithDeviceId:(NSString *)deviceId andFileName:(NSString *)fileName andIsShare:(BOOL)isShare andFileData:(NSData *)fileData uploadProgress:(KSUploadProgress)ksUploadProgress  finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

/**
 *  文件下载
 */
- (void)downLoadFileWithFileName:(NSString *)fileName andFileToken:(NSString *)token progress:(KSUploadProgress)progress finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

@end
