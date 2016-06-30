//
//  ChatVM.h
//  KinGuard
//
//  Created by RuanSTao on 16/6/30.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatVM : NSObject

- (void)getMessage:(NSString*)pid complete:(CompletionWithObjectBlock)block;

@end
