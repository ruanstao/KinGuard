//
//  JJSCell.h
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Description: JJS UITableView Cell
 */
@interface JJSCell : UITableViewCell

// Base class function, impletetion by subclass
- (void)configureCellWithCellDatas:(id)cellDatas;

// Default height is 44
+ (CGFloat)cellHeightForCellDatas:(NSDictionary *)cellDatas;

@end
