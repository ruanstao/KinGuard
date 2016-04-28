//
//  KSModel.m
//  TaiPoFun
//
//  Created by 郭祖宏 on 7/11/13.
//  Copyright (c) 2013 KineticSpace Limited. All rights reserved.
//

#import "JJSNetworking.h"
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
                        failed(KSLocalizedString(@"InvalidateData", @"InvalidateData"));
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
                    failed(KSLocalizedString(@"InvalidateData", @"InvalidateData"));
                }

            }

        } else {

            if (isPrivate) {

                NSError *error;
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
                if (!error) {
                    if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                        if ([resultDic[@"success"] integerValue] == KSStatusSucceed) {
                            finished(resultDic);
                        } else {
                            failed(resultDic[@"errorMsg"]);
                        }
                    } else {
                        failed(resultDic[@"errorMsg"]);
                    }
                } else {
                    failed(KSLocalizedString(@"InvalidateData", @"InvalidateData"));
                }

            } else {

                NSError *error;
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
                if (!error) {

                    finished(resultDic);

                } else {

                    failed(KSLocalizedString(@"InvalidateData", @"InvalidateData"));

                }

            }

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == -1009) {

            failed(KSLocalizedString(@"NetworkError", @"NetworkError"));

        } else {

            failed(KSLocalizedString(@"RequestWSException", @"RequestWSException"));

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
                    if ([resultDic[@"success"] integerValue] == KSStatusSucceed) {
                        finished(resultDic);
                    } else {
                        failed(resultDic[@"errorMsg"]);
                    }
                } else {
                    failed(KSLocalizedString(@"InvalidateData", @"InvalidateData"));
                }

            } else {
                failed(responseObject);
            }
        } else {
            NSError *error;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject                                                                                         options:kNilOptions error:&error];
            if (!error) {
                if (((NSHTTPURLResponse *)task.response).statusCode == 200) {
                    if ([resultDic[@"success"] integerValue] == KSStatusSucceed) {
                        finished(resultDic);
                    } else {
                        failed(resultDic[@"errorMsg"]);
                    }
                } else {
                    failed(resultDic[@"errorMsg"]);
                }
            } else {
                failed(KSLocalizedString(@"InvalidateData", @"InvalidateData"));
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == -1009) {

            failed(KSLocalizedString(@"NetworkError", @"NetworkError"));

        } else {

            failed(KSLocalizedString(@"RequestWSException", @"RequestWSException"));

        }

    }];
    //    [operation GET:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //    }];
}

//#pragma mark -
//#pragma mark download file from server
//- (void)downloadFileFromWSWithFilePath:(NSString *)filePath toSavePath:(NSString *)savePath finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed{
//
//    //------------
//    // coming soon
//    //------------
//
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *URL = [NSURL URLWithString:filePath];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        NSLog(@"File downloaded to: %@", filePath);
//    }];
//    [downloadTask resume];
//
//}

#pragma mark -
#pragma mark upload file to ks server
- (void)uploadFile:(NSData *)fileData path:(NSString *)path photoKey:(NSString *)photoKey fileName:(NSString *)fileName params:(NSDictionary *)params uploadProgress:(KSUploadProgress)uploadProgress finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed
{
    NSString *mimeType = [NSData contentTypeForImageData:fileData];
    //    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:self.httpMethod URLString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //        [formData appendPartWithFileData:fileData name:photoKey fileName:fileName mimeType:mimeType];
    //    }];

    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:self.httpMethod URLString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        [formData appendPartWithFileData:fileData name:photoKey fileName:fileName mimeType:mimeType];

    } error:nil];

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [sessionManager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {

    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error == nil) {
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            result = [result stringByReplacingOccurrencesOfString:@"\\" withString:@""];

            result = [result substringFromIndex:1];
            result = [result substringToIndex:result.length - 1];

            //         NSUInteger start = [result rangeOfString:@":\""].location;
            //         [result substringFromIndex:start];
            //         [result substringToIndex:result.length - 2];

            NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];

            NSError *error;
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data                                                                                         options:kNilOptions error:&error];

            if (!error) {
                if (((NSHTTPURLResponse *)response).statusCode == 200) {
                    //                 if ([resultDic[@"success"] integerValue] == KSStatusSucceed) {
                    //                     finished(nil);
                    //                 } else {
                    //                     failed(nil);
                    //                 }

                    finished(resultDic);

                } else {
                    failed(nil);
                }
            } else {
                failed(nil);
            }
        }else{
            failed(KSLocalizedString(@"NetworkError", @"NetworkError"));
        }
    }];
    [uploadTask resume];
    //    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //
    //    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    //
    ////        NSLog(@"bytes:%lld  expect:%lld",totalBytesWritten,totalBytesExpectedToWrite);
    //
    //        float sentValue = (float)totalBytesWritten / totalBytesExpectedToWrite;
    //        uploadProgress(sentValue);
    //
    //    }];
    //
    //    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    //     {
    ////
    //     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //     }];
    //
    //    [operation start];
}

//- (void)uploadFile:(NSData *)fileData path:(NSString *)path params:(NSDictionary *)params uploadProgress:(KSUploadProgress)uploadProgress finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed
//{
//
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFormData:fileData name:@"image"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"--Success: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"--Error: %@", error);
//    }];
//
//}

//- (void)uploadFile:(NSData *)fileData path:(NSString *)path photoKey:(NSString *)photoKey fileName:(NSString *)fileName params:(NSDictionary *)params uploadProgress:(KSUploadProgress)uploadProgress finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed
//{
//
//    NSString *mimeType = [NSData contentTypeForImageData:fileData];
//    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//        [formData appendPartWithFileData:fileData name:photoKey  fileName:fileName mimeType:mimeType];
//
//    } error:nil];
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)
//     {
//
//         float sentValue = (float)totalBytesWritten / totalBytesExpectedToWrite;
//         NSLog(@"setValue :%f",sentValue);
//         uploadProgress(sentValue);
//
//     }];
//
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//         result = [result stringByReplacingOccurrencesOfString:@"\\" withString:@""];
//
//         result = [result substringFromIndex:1];
//         result = [result substringToIndex:result.length - 1];
//
//         NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
//
//         NSError *error;
//         NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data                                                                                         options:kNilOptions error:&error];
//         NSLog(@"response :%@",resultDic);
//         [cell.tipLab setText:@"上传成功"];
//
//         NSString *syPath = [JJSUtil isImageSy:[resultDic objectForKey:@"filePath"]];
//         //                     NSRange range = [[resultDic objectForKey:@"filePath"] rangeOfString:@".jpg"];
//         //                     NSMutableString *syPath = [[NSMutableString alloc] initWithString:[resultDic objectForKey:@"filePath"]];
//         //                     [syPath insertString:@"_sy" atIndex:range.location];
//         NSLog(@"syPath is : %@ - ",syPath);
//
//         NSDictionary * jsonDic = @{@"type":[body objectForKey:@"album_type"],@"childType":[body objectForKey:@"album_type_child"],@"ytpath":[resultDic objectForKey:@"filePath"],@"sytpath":syPath,@"isFm":[body objectForKey:@"album_fm"]};
//         [photoJsonArray addObject:jsonDic];
//         
//         if (idx + 1 == waitUploadDataSource.count) {
//             completion(YES,@"");
//         }
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         
//         NSLog(@"error :%@",[error localizedFailureReason]);
//         [cell.tipLab setText:@"上传失败"];
//         
//         [[NSOperationQueue mainQueue] cancelAllOperations];
//         
//         if (self.delegate) {
//             [self.delegate performSelector:@selector(uploadPhotoSuccess)];
//         }
//         
//     }];
//    [operationArray addObject:operation];
//    
//    if (idx + 1 == waitUploadDataSource.count)
//    {
//        [[NSOperationQueue mainQueue] addOperations:operationArray waitUntilFinished:NO];
//    }
//    
//}

@end
