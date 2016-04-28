//
//  DashesLineView.m
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/1/18.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "DashesLineView.h"

@implementation DashesLineView

- (id)initWithFrame:(CGRect)frame

{
    
    self= [super initWithFrame:frame];
    
    if(self) {
        
        // Initialization code
        
    }
    
    return self;
    
}

// Only override drawRect: if you perform custom drawing.

// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect

{
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context,0.5);//线宽度
    
    CGContextSetStrokeColorWithColor(context,self.lineColor.CGColor);
    
    CGFloat lengths[] = {4,2};//先画4个点再画2个点
    
    CGContextSetLineDash(context,0, lengths,2);//注意2(count)的值等于lengths数组的长度
    
    CGContextMoveToPoint(context,self.startPoint.x,self.startPoint.y);
    
    CGContextAddLineToPoint(context,self.endPoint.x,self.endPoint.y);
    
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
    
}

@end
