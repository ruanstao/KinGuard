//
//  DeviceInfoView.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "DeviceInfoView.h"

@implementation DeviceInfoView

+ (instancetype)creatByNib
{
    NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"DeviceInfoView" owner:self options:nil] ;
    return [nib lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
