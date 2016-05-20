//
//  BindDeviceViewController.h
//  邦邦熊
//
//  Created by 莫菲 on 16/2/24.
//  Copyright © 2016年 linktop. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum:NSUInteger{

    TransType_FromHomePage = 0,
    TransType_FromLoginPage = 1
    
}TransType;

@interface BindDeviceViewController : KinViewController

@property(nonatomic, assign) TransType fromType;

@end
