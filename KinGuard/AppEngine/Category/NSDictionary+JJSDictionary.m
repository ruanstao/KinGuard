//
//  NSDictionary+JJSDictionary.m
//  JJSOA
//
//  Created by RuanSTao on 15/11/26.
//  Copyright © 2015年 JJSHome. All rights reserved.
//

#import "NSDictionary+JJSDictionary.h"

@implementation NSDictionary (JJSDictionary)

- (id)jjsObjectForKey:(id)aKey
{
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return obj;
}

- (id)jjsValueForKey:(id)aKey
{
    id obj = [self valueForKey:aKey];
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return obj;
}

@end
