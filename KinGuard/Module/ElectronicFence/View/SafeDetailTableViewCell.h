//
//  SafeDetailTableViewCell.h
//  KinGuard
//
//  Created by Rainer on 16/5/24.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafeDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labContent;

+ (SafeDetailTableViewCell *)cellForTableView:(UITableView *)tableView;

@end
