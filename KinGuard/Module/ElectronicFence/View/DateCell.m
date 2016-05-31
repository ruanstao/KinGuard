//
//  DateCell.m
//  KinGuard
//
//  Created by YD-邱荷凌 on 16/5/30.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "DateCell.h"

@implementation DateCell

+ (DateCell *)cellForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:@"DateCell" bundle:nil] forCellReuseIdentifier:@"dateCell"];
    DateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell"];
    if (!cell) {
        cell = [[DateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dateCell"];
    }
    return cell;
}

- (void)cellWithData:(NSDictionary *)body
{
    [self.labTitle setText:[body objectForKey:@"title"]];
    [self.labContent setText:[body objectForKey:@"value"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
