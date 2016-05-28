//
//  MemberShipViewController.h
//  KinGuard
//
//  Created by Rainer on 16/5/25.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "KinViewController.h"

typedef enum :NSInteger{

    FromType_Login = 0,
    FromType_Setting = 1
}FromType;
@interface MemberShipViewController : KinViewController

@property(nonatomic, assign) FromType type;

@end
