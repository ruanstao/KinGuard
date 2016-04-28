//
//  JJSTableDataSource.h
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <Foundation/Foundation.h>

// Cell Block，Configure Cell
typedef void (^CellConfigureBlock) (id cell, id cellDatas);

@interface JJSTableDataSource : NSObject<UITableViewDataSource>

/**
 *  Description: Datasources from Table model
 */
@property (strong, nonatomic) NSMutableArray                *tableItems;

/**
 *  Description: Cell identifier
 */
@property (copy, nonatomic, readonly) NSString              *cellIdentifier;

/**
 *  Description: Cell configure block
 */
@property (copy, nonatomic, readonly) CellConfigureBlock    cellConfigureBlock;

/**
 *  Description: Initialize cell
 *
 *  @param cellIdentifier     reuse identifier
 *  @param cellConfigureBlock cell configure block
 *
 *  @return cell
 */
- (id)initWithCellIdentifier:(NSString *)cellIdentifier
          cellconfigureBlock:(CellConfigureBlock)cellConfigureBlock cellClass:(Class)cla;


/**
 *  Description: Get Data according index path
 *
 *  @param indexPath Cell index path
 *
 *  @return Data
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
