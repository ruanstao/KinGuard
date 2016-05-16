//
//  MemberListCell.h
//  KinGuard
//
//  Created by Rainer on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *memberHeadView;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;

+ (MemberListCell *)cellForTableView:(UITableView *)tableView;

@end
