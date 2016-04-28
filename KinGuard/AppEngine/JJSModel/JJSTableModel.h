//
//  JJSTableModel.h
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JJSNetworking.h"

/**
 *  Description: Model of viewControler that has tableview 
 */
@interface JJSTableModel : NSObject

// 网络请求主类
@property (strong, nonatomic, readonly) JJSNetworking *networkRequest;

// TableView数据
@property (strong, nonatomic, readonly) NSMutableArray      *tableItems;

// 初始值为－1
@property (assign, nonatomic, readonly) NSInteger           totalPage;

// 初始值为0
@property (assign, nonatomic, readonly) NSInteger           toPage;

// 在更新数据时复位参数
- (void)resetRequestParams;

- (void)requestDataWithParams:(NSDictionary *)params forPath:(NSString *)path finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

- (void)updateModelData:(NSDictionary *)data;

@end
