//
//  JJSTableDelegate.m
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSTableDelegate.h"
#import "NewHouseCell.h"

@implementation JJSTableDelegate

- (id)init
{
    self = [super init];
    if (self)
    {
        //self.tableItems = [NSMutableArray array];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellHeight)
    {
        return self.cellHeight(indexPath);
    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = self.tableItems[indexPath.row];
    self.selectCell(indexPath, item);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 1)];
    view.backgroundColor = kClearColor;
    return view;
}

@end
