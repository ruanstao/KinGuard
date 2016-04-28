//
//  NSObject+Runtime.m
//  JJSOA
//
//  Created by 邱弘宇 on 16/1/21.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)
- (void)initMemberVariables{
    unsigned int count = 0;
    NSString *className = [[NSString alloc]initWithCString:object_getClassName(self) encoding:NSASCIIStringEncoding];
    Class class = NSClassFromString(className);
    Ivar *vars = class_copyIvarList(class, &count);
    for (unsigned int i; i<count; i++) {
        Ivar var = vars[i];
        const char *var_type = ivar_getTypeEncoding(var);
        NSString *value_class_name = [[NSString alloc]initWithCString:var_type encoding:NSASCIIStringEncoding];
        if ([value_class_name isEqualToString:@"@\"NSString\""]) {
            object_setIvar(self, var, @"");
        }
        else if ([value_class_name isEqualToString:@"@\"NSArray\""]){
            object_setIvar(self, var, [NSArray array]);
        }
        else if ([value_class_name isEqualToString:@"@\"NSMutableArray\""]){
            object_setIvar(self, var, [NSArray array]);
        }
        else if ([value_class_name isEqualToString:@"@\"NSMutableDictionary\""]){
            object_setIvar(self, var, [NSMutableDictionary dictionary]);
        }
        else if ([NSClassFromString(value_class_name) isSubclassOfClass:[NSObject class]]){
            object_setIvar(self, var, [[NSClassFromString(value_class_name) alloc]init]);
        }
    }
}
@end
