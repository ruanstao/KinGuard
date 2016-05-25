//
//  SetSafeZoneViewController.h
//  KinGuard
//
//  Created by Rainer on 16/5/24.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "KinViewController.h"
#import "SafeZoneModel.h"

typedef enum: NSInteger{

    SafeType_See = 0,
    SafeType_Edit = 1
    
}SafeType;

@interface SetSafeZoneViewController : KinViewController

@property (nonatomic, assign) SafeType type;
@property (nonatomic, strong) SafeZoneModel *safeModel;

@end
