//
//  TransparentView.m
//  JJSOA
//
//  Created by JJS-iMac on 15/5/23.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "TransparentView.h"

@implementation TransparentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}
@end
