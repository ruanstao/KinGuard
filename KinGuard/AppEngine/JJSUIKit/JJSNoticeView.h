//
//  JJSNoticeView.h
//  JJSOA
//
//  Created by YD-Guozuhong on 16/3/25.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJSNoticeView : UIView

@property (nonatomic, copy) void (^CloseNoticeViewBlock)();

- (void)configureWithBackgroundColor:(UIColor *)color NoticeContent:(NSString *)content closeButtonImageName:(NSString *)imageName;

@end
