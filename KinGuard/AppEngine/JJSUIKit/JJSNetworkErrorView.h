//
//  JJSNetworkErrorView.h
//  JJSOA
//
//  Created by YD-Guozuhong on 16/3/25.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSNetworkErrorView : UIView

@property (nonatomic, copy) void (^TryReloadAction)();

- (void)configureNetworkErrorViewWithTitle:(NSString *)title imageName:(NSString *)name;

@end
