//
//  KSModel.m
//  TaiPoFun
//
//  Created by 郭祖宏 on 7/11/13.
//  Copyright (c) 2013 KineticSpace Limited. All rights reserved.
//

#import "JJSNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
@implementation JJSNetworking
@synthesize httpMethod;

- (id)init
{
    self = [super init];
    if (self) {
        self.httpMethod = @"POST";
    }
    return self;
}

+ (id)sharedInstance
{
    static JJSNetworking *sharedNetworking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworking = [[self alloc] init];
    });
    return sharedNetworking;
}

+ (void)startMonitoringNetwork
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *message = nil;
        switch (status) {

            case AFNetworkReachabilityStatusNotReachable:{

                message = [NSString stringWithFormat:@"当前网络不可用"];

                break;

            }

            case AFNetworkReachabilityStatusReachableViaWiFi:{

                message = [NSString stringWithFormat:@"当前网络已切换为WiFi"];

                break;

            }

            case AFNetworkReachabilityStatusReachableViaWWAN:{

                message = [NSString stringWithFormat:@"当前网络已切换为2G/3G/4G网络"];

                break;

            }

            default:

                break;

        }
        [JJSUtil showHUDWithMessage:message autoHide:YES];
    }];
}

+ (BOOL)isNetworkReachable
{
    return ((AFNetworkReachabilityManager *)[AFNetworkReachabilityManager sharedManager]).reachable;
}

#pragma mark -
#pragma mark request data from ks server with params
- (void)requestDataFromWSWithParams:(NSDictionary *)params forPath:(NSString *)path isJson:(BOOL)isJson isPrivate:(BOOL)isPrivate finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed
{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 60;
    //    AFHTTPRequestOperationManager *operation = [AFHTTPRequestOperationManager manager];
    //    [operation.requestSerializer setTimeoutInterval:60];
    //    [operation setRequestSerializer:[AFJSONRequestSerializer serializer]];

    //    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    if (!isJson) {

        //        [operation setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        sessionManager.responseSerializer= [AFHTTPResponseSerializer serializer];

    } else {

        //        [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];

    }

    [sessionManager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isJson) {
            if(isPrivate){

                //                if ([operation.response statusCode] == 200) {
                if ( ((NSHTTPURLResponse *)task.response).statusCode == 200) {
                    if([responseObject isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary *resultDic = (NSDictionary *)responseObject;
                        if (resultDic[@"success"] != nil) {
                            finished(resultDic);
                        } else {
                            failed(resultDic[@"errorMsg"]);
                        }
                    } else {
                        failed(@"网络错误");
                    }

                } else {
                    failed(responseObject);
                }

            } else {

                if([responseObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *resultDic = (NSDictionary *)responseObject;
                    finished(resultDic);

                } else {
                    failed(@"网络错误");
                }

            }

        } else {

            if (isPrivate) {

                NSError *error;
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
                if (!error) {
                    if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                        if ([resultDic[@"success"] integerValue] == 1) {
                            finished(resultDic);
                        } else {
                            failed(resultDic[@"errorMsg"]);
                        }
                    } else {
                        failed(resultDic[@"errorMsg"]);
                    }
                } else {
                    failed(@"网络错误");
                }

            } else {

                NSError *error;
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
                if (!error) {

                    finished(resultDic);

                } else {

                    failed(@"网络错误");

                }

            }

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == -1009) {

            failed(@"网络错误");

        } else {

            failed(@"网络错误");

        }

    }];


    //    [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    //    [operation POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //    }];

    //    [operation start];

}
- (void)getDataFromParams:(NSDictionary *)params
                   forUrl:(NSString *)url
                   isJson:(BOOL)isJson
                 finished:(KSFinishedBlock)finished
                   failed:(KSFailedBlock)failed
{
    //    AFHTTPRequestOperationManager *operation = [AFHTTPRequestOperationManager manager];
    //    [operation.requestSerializer setTimeoutInterval:60];
    //    if (!isJson) {
    //
    //        [operation setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    //
    //    } else {
    //
    //        [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    ////        [operation.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil]];
    //    }
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer.timeoutInterval = 60;

    if (!isJson) {

        sessionManager.responseSerializer= [AFHTTPResponseSerializer serializer];

    } else {

        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];

    }
    [sessionManager GET:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isJson) {
            if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                if([responseObject isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *resultDic = (NSDictionary *)responseObject;
                    if ([resultDic[@"success"] integerValue] == 1) {
                        finished(resultDic);
                    } else {
                        failed(resultDic[@"errorMsg"]);
                    }
                } else {
                    failed(@"网络错误");
                }

            } else {
                failed(responseObject);
            }
        } else {
            NSError *error;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
            if (!error) {
                if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                    if ([resultDic[@"success"] integerValue] == 1) {
                        finished(resultDic);
                    } else {
                        failed(resultDic[@"errorMsg"]);
                    }
                } else {
                    failed(resultDic[@"errorMsg"]);
                }
            } else {
                failed(@"网络错误");
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == -1009) {

            failed(@"网络错误");

        } else {

            failed(@"网络错误");

        }

    }];

}



@end
