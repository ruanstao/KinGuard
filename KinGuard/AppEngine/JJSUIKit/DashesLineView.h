//
//  DashesLineView.h
//  JJSOA
//
//  Created by YD-zhangjiyu on 16/1/18.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSView.h"

@interface DashesLineView : JJSView

@property(nonatomic,assign)CGPoint startPoint;//虚线起点

@property(nonatomic,assign)CGPoint endPoint;//虚线终点

@property(nonatomic,strong)UIColor* lineColor;//虚线颜色

@end
