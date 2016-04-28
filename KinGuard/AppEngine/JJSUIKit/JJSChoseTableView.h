//
//  JJSChoseTableView.h
//  JJSOA
//
//  Created by jjs on 15-3-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityDao.h"
#import "CityInfo.h"

@interface JJSChoseTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *oneTableView;
    UITableView *twoTableView;
    UITableView *threeTableView;
    NSInteger currentIndex;
    NSArray *titleArray;
    NSMutableArray *subArray;
    ChoseType choseType;
    CityInfo *areaCity;
    
    //更多 当前行
    NSInteger moreIndex;
    
//    NSMutableDictionary *params;
    NSMutableDictionary * _userInfo; //更多参数
}
@property (nonatomic , strong) void (^ClickActionBlock)(NSDictionary *titleDic);

- (id)initWithFrame:(CGRect)frame withTableCount:(TableCount)tableCount withDataSource:(NSArray *)array with:(ChoseType)fileType withSnCode:(NSString *)snCode;
- (id)initWithFrame:(CGRect)frame withTableCount:(TableCount)tableCount withDataSource:(NSArray *)array with:(ChoseType)fileType withSnCode:(NSString *)snCode withUserInfo:(NSDictionary *)userInfo;

@end
