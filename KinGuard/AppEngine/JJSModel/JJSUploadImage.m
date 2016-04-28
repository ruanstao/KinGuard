//
//  JJSUploadImage.m
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/30.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSUploadImage.h"
#import <QiniuSDK.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "AlbumInfo.h"

@implementation JJSUploadImage

/**
 *  获取七牛云存储上传图片的token
 */
- (void)getUploadImageToken:(CompletionWithObjectBlock)completion
{
    [[JJSNetworking sharedInstance] getDataFromParams:@{} forUrl:KGetUploadToken isJson:YES isAuthorizationHeader:YES finished:^(NSDictionary *data) {
        NSLog(@"data:%@",data);
        if ([[data objectForKey:@"success"] boolValue]) {
            completion(YES,[data objectForKey:@"data"]);
            
        } else {
            completion(NO,[data objectForKey:@"errorMsg"]);
        }
        
    } failed:^(NSString *error) {
        completion(NO,error);
    }];
}

/**
 *  上传图片到七牛云盘SDk接口
 *
 *  @param token    上传凭证
 *  @param imgData  照片数据
 *  @param imageKey 照片名称
 *  @param complet  CompletionWithObjectBlock上传完成后的回调函数  @param info 上下文信息，包括状态码，错误值  @param key  上传时指定的key，原样返回  @param resp 上传成功会返回文件信息，失败为nil; 可以通过此值是否为nil 判断上传结果
 */
- (void)uploadImageToQiniuWithToken:(NSString *)token imageStr:(NSData *)imageData imageKey:(NSString *)imageKey comlete:(CompletionWithObjectBlock)complete
{
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    [upManager putData:imageData key:nil token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info%@", info);
        NSLog(@"resp%@", resp);
        if (resp != nil) {
            complete (YES,resp);
        } else {
            complete (NO,@"图片上传云盘失败");
        }
        
    } option:nil];
    imageData = nil;
}

/**
 *  封装好的上传图片至七牛云API
 *
 *  @param pictureArr 图片在ALAssetsLibrary中的数组
 *  @param completion 成功返回图片对应的网络地址，失败返回提示语
 */
- (void)uploadImageToQiniu:(NSArray *)pictureArr complete:(CompletionWithObjectBlock)completion
{
    NSMutableArray *paramList = [NSMutableArray array];
    [self getUploadImageToken:^(BOOL finish, id obj) {
        if (!finish) {
            completion (NO, obj);
            return ;
        }
        
        NSString *token = [obj objectForKey:@"token"];
        if ([token isEqualToString:@""] || token == nil) {
            completion(NO,@"token获取失败");
            return;
        }
        
        __block NSInteger success = [pictureArr count];
        NSLog(@"速销图片总数：%@",@(success));
        
        [pictureArr enumerateObjectsUsingBlock:^(AlbumInfo *objPic, NSUInteger idxPic, BOOL * _Nonnull stop) {
            
            ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
            [assetLibrary assetForURL:objPic.albumUrl != nil ? objPic.albumUrl:[NSURL URLWithString:objPic.photoPath] resultBlock:^(ALAsset *asset) {
                @autoreleasepool {
                    UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
                    
                    if (!image) {
                        completion(NO, @"加载图片资源失败，请重新尝试");
                        *stop = YES;
                        return ;
                    }
                    NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
                    //NSData *imgData = UIImagePNGRepresentation(image);
                    image = nil;
                    [self uploadImageToQiniuWithToken:token imageStr:imgData imageKey:objPic.albumUrl != nil ? [objPic.albumUrl absoluteString]:objPic.photoPath comlete:^(BOOL finish, id obj) {
                        NSLog(@"obj:%@",obj);
                        if (!finish) {
                            completion (NO,obj);
                            return ;
                        }
                        success -- ;
                        NSString *ImageKey = [NSString stringWithFormat:@"/%@",[obj jjsObjectForKey:@"key"]];
                        objPic.photoPath = ImageKey;
                        objPic.syPhotoPath =[NSString stringWithFormat:@"/%@",[obj jjsObjectForKey:@"sykey"]];// @"水印地址";
                        [paramList addObject:objPic];
                        if (success == 0) {
                            NSLog(@"图片全部上传完毕");
                            //返回图片在云存储的网络地址
                            completion (YES, paramList);
                        }
                    }];
                    imgData = nil;
                }
                
            } failureBlock:^(NSError *error) {
                completion(NO, @"读取图片资源失败，请重新选择图片上传");
                *stop = YES;
            }];
            
        }];
        
    }];
}






@end
