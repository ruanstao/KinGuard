//
//  NSDictionary+JJSDictionary.h
//  JJSOA
//
//  Created by RuanSTao on 15/11/26.
//  Copyright © 2015年 JJSHome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JJSDictionary)

- (id)jjsObjectForKey:(id)aKey;

- (id)jjsValueForKey:(id)aKey;

@end
