//
//  SafeTableViewCell.m
//  KinGuard
//
//  Created by Rainer on 16/5/18.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "SafeTableViewCell.h"

@implementation SafeTableViewCell

+ (SafeTableViewCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"SafeTableViewCell" bundle:nil] forCellReuseIdentifier:@"safeCell"];
    SafeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeCell"];
    if (!cell) {
        cell = [[SafeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"safeCell"];
    }
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
