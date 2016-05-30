//
//  DateCell.h
//  KinGuard
//
//  Created by YD-邱荷凌 on 16/5/30.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UIButton *monday;
@property (weak, nonatomic) IBOutlet UIButton *tuesday;
@property (weak, nonatomic) IBOutlet UIButton *wednesday;
@property (weak, nonatomic) IBOutlet UIButton *thursday;
@property (weak, nonatomic) IBOutlet UIButton *friday;
@property (weak, nonatomic) IBOutlet UIButton *saturday;
@property (weak, nonatomic) IBOutlet UIButton *sunday;

+ (DateCell *)cellForTableView:(UITableView *)tableView;
- (void)cellWithData:(NSDictionary *)body;

@end
