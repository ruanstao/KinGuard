//
//  NSTimer+Addition.h
//  JJSOA
//
//  Created by Koson on 15-2-12.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
