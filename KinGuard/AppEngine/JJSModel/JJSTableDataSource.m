//
//  JJSTableDataSource.m
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSTableDataSource.h"
#import "NewHouseCell.h"

@interface JJSTableDataSource ()
@property (copy, nonatomic) NSString            *cellIdentifier;
@property (copy, nonatomic) CellConfigureBlock  cellConfigureBlock;

@property (copy, nonatomic) Class CellClass;

@end

@implementation JJSTableDataSource

- (id)initWithCellIdentifier:(NSString *)cellIdentifier cellconfigureBlock:(CellConfigureBlock)cellConfigureBlock cellClass:(Class)cla
{
    self = [super init];
    if (self)
    {
        self.cellIdentifier     = cellIdentifier;
        self.cellConfigureBlock = [cellConfigureBlock copy];
        self.CellClass = cla;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableItems[(NSUInteger) indexPath.row];
}


#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JJSCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    if (!cell) {
        
        cell = [[self.CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
        
    }
    
    id item = [self itemAtIndexPath:indexPath];
    self.cellConfigureBlock(cell, item);
    return cell;
}

@end
