//
//  ElectronicVM.m
//  KinGuard
//
//  Created by Rainer on 16/5/24.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "ElectronicVM.h"

@implementation ElectronicVM

+ (NSMutableArray *)fitterDataWith:(SafeZoneModel *)model
{
    NSMutableArray *dataSource = [NSMutableArray array];
    
    [dataSource addObject:@[@{@"title":@"区域名称",@"value":model.alias}]];
    [dataSource addObject:@[@{@"title":@"进入区域时间",@"value":model.in_timestamp},@{@"title":@"离开区域时间",@"value":model.out_timestamp}]];
    [dataSource addObject:@[@{@"title":@"有效日期",@"value":model.days}]];
    return dataSource;
}

@end
