//
//  testApi.h
//  StudentCardApi
//
//  Created by RuanSTao on 16/4/1.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeDefines.h"

@interface KinGuartApi : NSObject

+ (KinGuartApi *)sharedKinGuard;

// APP Key, 在使用服务器之前需要先绑定key.
@property (nonatomic, copy) NSString *appKey;

// APP Secret, 服务器秘钥
@property (nonatomic, copy) NSString *appSecret;

#pragma mark - 账户操作
/**
 *  注册
 *
 *  @param mobile    手机号码
 *  @param password  密码
 *  @param smscode   验证码
 *  @param successed
 *  @param failed
 */
- (void)registerAppAccountMobile:(NSString *)mobile withPassword:(NSString *)password withSmscode:(NSString *)smscode success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

/**
 *  密码设置
 *
 *  @param mobile    手机号码
 *  @param password  密码
 *  @param successed
 *  @param failed
 */
- (void)setNewPasswordMobile:(NSString *)mobile withPassword:(NSString *)password withSmscode:(NSString *)smscode success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

/**
 *  密码报失
 *
 *  @param mobile    手机号码
 *  @param successed
 *  @param failed
 */
- (void)reportLostPasswordMobile:(NSString *)mobile success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

/**
 *  修改密码
 *
 *  @param mobile    手机号码
 *  @param oldpwd    旧密码
 *  @param newpwd    新密码
 *  @param successed
 *  @param failed
 */
- (void)revisePasswordMobile:(NSString *)mobile withOldPwd:(NSString *)oldpwd withNewPwd:(NSString *)newpwd success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;


/**
 *  获取短信验证码
 *
 *  @param mobile    手机号码
 *  @param smstype   填 0 或“账号注册”、1 或“密码重置”、2 或“关 注宝贝”
 *  @param successed
 *  @param failed
 */
- (void)catchSmsCodeWithMobile:(NSString *)mobile withSmstype:(NSString *)smstype success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

/**
 *  账户注册短信认证
 *
 *  @param mobile    手机号码
 *  @param smscode   验证码
 *  @param successed
 *  @param failed
 */
- (void)regSmsCheckWithMobile:(NSString *)mobile withSmsCode:(NSString *)smscode success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

#pragma mark - 用户信息设定
/**
 *  更新用户信息
 *
 *  @param mobile    手机号码
 *  @param addr      住址
 *  @param iddno     身份证号
 *  @param accname   姓名
 *  @param alias     昵称 别名
 *  @param successed
 *  @param failed
 */
- (void)updateUserInfoWithMobile:(NSString *)mobile withAddr:(NSString *)addr withIddno:(NSString *)iddno withAccName:(NSString *)accname withAlias:(NSString *)alias withSex:(NSString *)sex withBirthdate:(NSString *)birthdate success:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

/**
 *  获取用户信息
 *
 *  @param successed
 *  @param failed
 */
- (void)getUserInfoSuccess:(KSFinishedBlock)successed fail:(KSFailedBlock)failed;

/**
 *  用户头像上传
 *
 *  @return
 */
- (void)uploadHeadPortraitByPid:(NSString * _Nonnull)pid withImageData:( NSData * _Nonnull )imageData uploadProgress:(KSUploadProgress _Nonnull)ksUploadProgress  finished:(KSFinishedBlock _Nonnull)finished failed:(KSFailedBlock _Nonnull)failed;

/**
 *  用户头像下载
 *
 *  @return
 */
- (void)downloadHeadPortraitByPid:(NSString  * _Nonnull)pid andProgress:(KSUploadProgress _Nonnull)progress finished:(KSFinishedBlock _Nonnull)finished failed:(KSFailedBlock _Nonnull)failed;

#pragma mark - 登录模块

/**
 *  登录
 *
 *  @param mobile    手机号码
 *  @param password  密码
 *  @param successed
 *  @param failed
 */
- (void)loginWithMobile:(NSString * _Nonnull)mobile withPassword:(NSString * _Nonnull)password success:(KSFinishedBlock _Nonnull)successed fail:(KSFailedBlock _Nonnull)failed;

/**
 *  退出登录
 *
 *  @param mobile    手机号码
 *  @param successed
 *  @param failed
 */
- (void)loginOutWithMobile:(NSString * _Nonnull)mobile success:(KSFinishedBlock _Nonnull)successed fail:(KSFailedBlock _Nonnull)failed;

@end
