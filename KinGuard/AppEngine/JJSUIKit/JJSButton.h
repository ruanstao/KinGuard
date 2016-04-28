//
//  JJSButton.h
//  JJSOA
//
//  Created by Koson on 15-2-12.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  A Custom UIButton
 *
 *  @since 1.0.0
 */
@interface JJSButton : UIButton

@property (nonatomic , assign) CGRect imageViewRect;
@property (nonatomic , assign) CGRect titleViewRect;
@property (nonatomic , assign) BOOL clicked;
@property (nonatomic , strong) NSDictionary * userInfo;
@end
