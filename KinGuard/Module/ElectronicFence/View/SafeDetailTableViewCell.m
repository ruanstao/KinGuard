//
//  SafeDetailTableViewCell.m
//  KinGuard
//
//  Created by Rainer on 16/5/24.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "SafeDetailTableViewCell.h"

@implementation SafeDetailTableViewCell

+ (SafeDetailTableViewCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"SafeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"safeDetailCell"];
    SafeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeDetailCell"];
    if (!cell) {
        cell = [[SafeDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"safeDetailCell"];
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
