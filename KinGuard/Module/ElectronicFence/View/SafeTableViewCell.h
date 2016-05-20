//
//  SafeTableViewCell.h
//  KinGuard
//
//  Created by Rainer on 16/5/18.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;

+ (SafeTableViewCell *)cellForTableView:(UITableView *)tableView;

@end
