//
//  UserModel.h
//  KinGuard
//
//  Created by Rainer on 16/5/6.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, assign) BOOL isLogined;

@end
