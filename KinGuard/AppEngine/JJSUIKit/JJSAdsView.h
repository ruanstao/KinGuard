//
//  JJSAdsView.h
//  JJSOA
//
//  Created by Koson on 15-2-12.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Description: JJS ads view
 */
@interface JJSAdsView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;


/**
 *  Description: Initializer
 *
 *  @param frame             Frame
 *  @param animationDuration Auto scroll timerInterval(less or equal zero will invalidate)
 *
 *  @return Instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration pagesCount:(NSInteger)count;


/**
 *  Description: Datasource to get page total number
 */
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);


/**
 *  Description: Datasource to get contentView of Index
 */
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);



/**
 *  Description: Click block
 */
@property (nonatomic , copy) void (^ClickActionBlock)(NSInteger pageIndex);


- (void)animationTimerDidFired;

@end
