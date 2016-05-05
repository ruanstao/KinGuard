//
//  TypeDefines.h
//  StudentCardApi
//
//  Created by RuanSTao on 16/4/8.
//  Copyright © 2016年 JJS-iMac. All rights reserved.
//

#ifndef TypeDefines_h
#define TypeDefines_h

typedef void (^CompletionBlock)(BOOL finish);

//Success And Failed Blocks
typedef void (^KSFinishedBlock) (NSDictionary *data);
typedef void (^KSFailedBlock)   (NSString *error);
typedef void (^KSUploadProgress) (NSProgress *progress);
typedef void (^KSDownloadProgress) (NSProgress *progress);

#endif /* TypeDefines_h */
