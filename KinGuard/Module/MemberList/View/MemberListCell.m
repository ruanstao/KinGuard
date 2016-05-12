//
//  MemberListCell.m
//  KinGuard
//
//  Created by Rainer on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "MemberListCell.h"

@implementation MemberListCell

+ (MemberListCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"MemberListCell" bundle:nil] forCellReuseIdentifier:@"memberCell"];
    MemberListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell"];
    if (!cell) {
        cell = [[MemberListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"memberCell"];
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
