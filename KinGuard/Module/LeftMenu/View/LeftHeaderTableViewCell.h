//
//  LeftHeaderTableViewCell.h
//  KinGuard
//
//  Created by RuanSTao on 16/5/6.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIButton *header;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@end
