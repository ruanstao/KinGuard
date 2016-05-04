//
//  KSModel.h
//  TaiPoFun
//
//  Created by 郭祖宏 on 7/11/13.
//  Copyright (c) 2013 KineticSpace Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

//Success And Failed Blocks
typedef void (^KSFinishedBlock) (NSDictionary *data);
typedef void (^KSFailedBlock)   (NSString *error);
typedef void (^KSUploadProgress) (float progressValue);

//Load More And Update Data Block
typedef void (^KSLoadMoreDataBlock) (void);
typedef void (^KSUpdateDataBlock) (void);

//Completion Block(with object)
typedef void (^CompletionWithObjectBlock) (BOOL finish, id obj);
typedef void (^CompletionWithDoubleBlock) (BOOL finish, id obj, id obj2);
typedef void (^CompletionBlock)(BOOL finish);


/**
 *  It's for  AFNetworking 1.x, Just adapter iOS 7.0 and higher
 *
 *  @since 1.0.0
 */
@interface JJSNetworking : NSObject

+ (id)sharedInstance;
+ (void)startMonitoringNetwork;
+ (BOOL)isNetworkReachable;
//Network Request Method(default is POST)
@property (nonatomic , copy) NSString *httpMethod;

//Request Data From KS Web Services with params
- (void)requestDataFromWSWithParams:(NSDictionary *)params
                            forPath:(NSString *)path
                             isJson:(BOOL)isJson
                          isPrivate:(BOOL)isPrivate
                           finished:(KSFinishedBlock)finished
                             failed:(KSFailedBlock)failed;
//带Authorization请求头
- (void)requestDataFromWSWithParams:(NSDictionary *)params
                            forPath:(NSString *)path
                             isJson:(BOOL)isJson
                          isPrivate:(BOOL)isPrivate
              isAuthorizationHeader:(BOOL)isAuthorization
                           finished:(KSFinishedBlock)finished
                             failed:(KSFailedBlock)failed;

/**
 *  GET
 *
 *  @param params   参数
 *  @param url      请求地址
 *  @param isJson   是否是json格式
 *  @param finished 请求完成
 *  @param failed   请求失败
 */
- (void)getDataFromParams:(NSDictionary *)params
                   forUrl:(NSString *)url
                   isJson:(BOOL)isJson
                 finished:(KSFinishedBlock)finished
                   failed:(KSFailedBlock)failed;

- (void)getDataFromParams:(NSDictionary *)params
                   forUrl:(NSString *)url
                   isJson:(BOOL)isJson
    isAuthorizationHeader:(BOOL)isAuthorization
                 finished:(KSFinishedBlock)finished
                   failed:(KSFailedBlock)failed;
/**
 post 方式
 */
- (void)postDataWithParams:(NSDictionary *)params forUrl:(NSString *)url
                  isJson:(BOOL)isJson
   isAuthorizationHeader:(BOOL)isAuthorization
                finished:(KSFinishedBlock)finished
                  failed:(KSFailedBlock)failed;


@end
