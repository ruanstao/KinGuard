//
//  JJSUINavigationController.m
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/4/1.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSUINavigationController.h"

@implementation JJSUINavigationController


+ (void)initialize{
    
    //设置导航栏下面那条黑线透明
    UINavigationBar *bar = [UINavigationBar appearance];
   
    [bar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
}


@end
