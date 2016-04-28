//
//  JJSCell.m
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSCell.h"

@implementation JJSCell

//- (void)awakeFromNib {
//    // Initialization code
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)cellHeightForCellDatas:(NSDictionary *)cellDatas
{
    return 44;
}

- (void)configureCellWithCellDatas:(id)cellDatas{}

@end
