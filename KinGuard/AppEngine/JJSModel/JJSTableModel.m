//
//  JJSTableModel.m
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSTableModel.h"

@interface JJSTableModel ()
@property (strong, nonatomic) JJSNetworking  *networkRequest;
@property (strong, nonatomic) NSMutableArray    *tableItems;
@property (assign, nonatomic) NSInteger         totalPage;
@property (assign, nonatomic) NSInteger         toPage;

// Update model data, impletetion by subclass.
//- (void)updateModelData:(NSDictionary *)datas;

//- (void)requestDataWithParams:(NSDictionary *)params forPath:(NSString *)path finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;

@end

@implementation JJSTableModel

- (id)init
{
    if ([super init])
    {
        self.networkRequest = [[JJSNetworking alloc] init];
        [self resetRequestParams];
        self.tableItems = [NSMutableArray array];
    }
    return self;
}

- (void)resetRequestParams
{
    //    self.refreshData = YES;
    self.toPage      = 0;
    self.totalPage   = -1;
    [self.tableItems removeAllObjects];
}

- (void)requestDataWithParams:(NSDictionary *)params forPath:(NSString *)path finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed
{
    
    [self.networkRequest requestDataFromWSWithParams:params forPath:path isJson:YES isPrivate:YES finished:^(NSDictionary *data){
    
        finished(data);
        
    } failed:^(NSString *error){
    
        failed(error);
        
    }];
    
}

- (void)updateModelData:(NSDictionary *)data
{
    self.totalPage = [data[@"total"] integerValue];
    self.toPage    = [data[@"index"] integerValue] + 1;
    [self.tableItems addObjectsFromArray:data[@"body"]];
}

@end
