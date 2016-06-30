//
//  ChatVM.m
//  KinGuard
//
//  Created by RuanSTao on 16/6/30.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "ChatVM.h"
@implementation ChatVM

- (void)getMessage:(NSString*)pid complete:(CompletionWithObjectBlock)block
{
    
    [[KinRecordApi sharedKinRecordApi] getChatMessage:pid chatContent:@"" fromDate:@"00:00:00" toDate:@"23:59:59" finished:^(NSDictionary *data) {
        
        NSLog(@"%@",data);
    } failed:^(NSString *error) {
        
        NSLog(@"%@",error);
    }];
}

////上传聊天信息
//- (void)uploadChatMessageToAcc:(NSString *)acc chatContent:(NSString *)message finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;
//
////获取聊天信息
//- (void)getMessageToAcc:(NSString *)acc fromDate:(NSString *)fromDate toDate:(NSString *)toDate finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;
//
////群聊信息上传
//- (void)uploadMessageToPid:(NSString *)pid chatContent:(NSString *)chatcontent finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;
//
////获取群聊信息
//- (void)getChatMessage:(NSString *)pid chatContent:(NSString *)chatcontent fromDate:(NSString *)fromDate toDate:(NSString *)toDate finished:(KSFinishedBlock)finished failed:(KSFailedBlock)failed;
@end
