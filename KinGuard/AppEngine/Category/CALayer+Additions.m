//
//  CALayer+Additions.m
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/1/12.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "CALayer+Additions.h"

@implementation CALayer (Additions)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
