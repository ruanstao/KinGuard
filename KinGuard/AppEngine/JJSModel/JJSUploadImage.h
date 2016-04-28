//
//  JJSUploadImage.h
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/30.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJSUploadImage : NSObject

/**
 *  获取七牛云存储上传图片的token
 */
- (void)getUploadImageToken:(CompletionWithObjectBlock)completion;

/**
 *  上传图片到七牛云盘
 *
 *  @param token    上传凭证
 *  @param imgData  照片数据
 *  @param imageKey 照片名称
 *  @param complet
 */
- (void)uploadImageToQiniuWithToken:(NSString *)token imageStr:(NSData *)imgData imageKey:(NSString *)imageKey comlete:(CompletionWithObjectBlock)complete;

/**
 *  封装好的上传图片至七牛云API
 *
 *  @param pictureArr 图片在ALAssetsLibrary中的数组
 *  @param completion 成功返回图片对应的网络地址，失败返回提示语
 */
- (void)uploadImageToQiniu:(NSArray *)pictureArr complete:(CompletionWithObjectBlock)completion;



@end
