//
//  JJSTableDelegate.h
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <Foundation/Foundation.h>

//配置路径下的cell高
typedef CGFloat (^CellHeightBlock) (NSIndexPath *indexPath);

//选中某行时的block
typedef void (^SelectCellBlock) (NSIndexPath *indexPath, id item);

@interface JJSTableDelegate : NSObject<UITableViewDelegate>

//数据源，由数据模型给定，与DataSource一致
@property (strong, nonatomic) NSMutableArray    *tableItems;

@property (copy, nonatomic) SelectCellBlock     selectCell;

//如果没有设置，则为默认的44高
@property (copy, nonatomic) CellHeightBlock     cellHeight;

@property (copy, nonatomic) KSLoadMoreDataBlock loadMoreData;
@property (copy, nonatomic) KSUpdateDataBlock   updateData;

@end
