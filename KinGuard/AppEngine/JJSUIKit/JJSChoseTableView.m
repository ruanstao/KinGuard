//
//  JJSChoseTableView.m
//  JJSOA
//
//  Created by jjs on 15-3-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import "JJSChoseTableView.h"
#define TABLE_TAG 6000
#define TAG_BUTTON 7001

@implementation JJSChoseTableView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        params = [@{} mutableCopy];
        self.clipsToBounds = YES;
    }
    return self;
}

//- (void)dealloc
//{
//    NSLog(@"%@ dealloc", [self class]);
//}

- (id)initWithFrame:(CGRect)frame withTableCount:(TableCount)tableCount withDataSource:(NSArray *)array with:(ChoseType)fileType withSnCode:(NSString *)snCode
{
    return [self initWithFrame:frame withTableCount:tableCount withDataSource:array with:fileType withSnCode:snCode withUserInfo:nil];
}

- (id)initWithFrame:(CGRect)frame withTableCount:(TableCount)tableCount withDataSource:(NSArray *)array with:(ChoseType)fileType withSnCode:(NSString *)snCode withUserInfo:(NSDictionary *)userInfo
{
    self = [self initWithFrame:frame];
    _userInfo = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    currentIndex = tableCount;
    choseType = fileType;
    titleArray = array;
    CityInfo *city = [[CityInfo alloc] init];
    city.cityName = @"不限";
    city.snCode = nil;
    
    areaCity = [[CityInfo alloc] init];
    areaCity.cityName = @"不限";
    areaCity.snCode = nil;
 
    subArray = [@[] mutableCopy];
    [subArray addObject:city];
    NSArray *buttonArray = @[@"重置",@"确定"];
    
    if (self) {
        for (int i = 0; i < tableCount; i++) {
            CGRect frame1 = (CGRect){
                .origin.x = frame.size.width/tableCount * i,
                .origin.y = 0,
                .size.width =  frame.size.width/tableCount,
                .size.height = frame.size.height
            };
            if (choseType == ChoseTypeMore) {
                frame1 = (CGRect){
                    .origin.x = frame.size.width/tableCount * i,
                    .origin.y = 0,
                    .size.width =  frame.size.width/tableCount,
                    .size.height = frame.size.height - 44
                };
            }
            UITableView *choseTableView = [[UITableView alloc] initWithFrame:(CGRect){frame1.origin.x,-frame1.size.height,frame1.size.width,frame1.size.height} style:UITableViewStylePlain];
            [choseTableView setTag:(TABLE_TAG + i)];
            [choseTableView setDelegate:self];
            [choseTableView setDataSource:self];
            [choseTableView setBackgroundColor:kBackgroundGray];
            [choseTableView setShowsVerticalScrollIndicator:NO];
            [choseTableView setSeparatorColor:kSeparatorColor];
            [JJSUtil setExtraCellLineHidden:choseTableView];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [choseTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            
            // for ios 7
            if ([choseTableView respondsToSelector:@selector(setSeparatorInset:)]) {
                
                [choseTableView setSeparatorInset:UIEdgeInsetsZero];
                
            }
            
            // for ios8
            if ([choseTableView respondsToSelector:@selector(setLayoutMargins:)])  {
                [choseTableView setLayoutMargins:UIEdgeInsetsZero];
            }
            [self addSubview:choseTableView];
            
            
            [UIView animateWithDuration:0.3 animations:^{
                
                [choseTableView setFrame:frame1];
                
            } completion:^(BOOL finished) {
                if (choseType == ChoseTypeMore) {
                    
                    UIButton * czButton = [UIButton buttonWithType:UIButtonTypeCustom];
                    [czButton setFrame:CGRectMake(mScreenWidth/2 * i, frame.size.height - 44, mScreenWidth/2, 44)];
                    [czButton setBackgroundColor:kWhiteColor];
                    [czButton setExclusiveTouch:YES];
                    [czButton setTag:TAG_BUTTON + i];
                    [czButton setTitle:buttonArray[i] forState:UIControlStateNormal];
                    [czButton setTitleColor:HexRGB(0x333333) forState:UIControlStateNormal];
                    [czButton addTarget:self action:@selector(czAction:) forControlEvents:UIControlEventTouchUpInside];
                    [self addSubview:czButton];
                    
                    if (i == 0) {
                        [self addSubview:[JJSUtil getSeparator:kSeparatorColor frame:CGRectMake(mScreenWidth/2 - 0.618, frame.size.height - 44 , 0.618, 44)]];
                    }
                }
            }];
        }
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        if (nil != userInfo) {
            switch (choseType) {
                case ChoseTypeClassification:{
                    [self scrollClassificaton];
                }
                    break;
                case ChoseTypeAreaInfo:{
                    [self scrollAreaInfo];
                }
                    break;
                case ChoseTypePrice:{
                    [self scrollChosePrice];
                }
                    break;
                case ChoseTypeBuildArea:{
                    
                }
                    break;
                case ChoseTypeHouseType:{
                    
                }
                    break;
                case ChoseTypeMore:{
                    [self scrollChoseMore];
                }
                    break;
                default:
                    break;
            }

        }
    });

    return self;
}

-(void)scrollClassificaton
{
    NSInteger row = [[_userInfo objectForKey:@"type"] integerValue];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self tableViewScrollToRow: indexPath andTwoTableRow:nil];
}

- (void)scrollAreaInfo
{
    __weak JJSChoseTableView * weakSelf = self;
    __block NSIndexPath *titleIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    __block NSIndexPath *subTitleindexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSString * cqId = [_userInfo objectForKey:@"cqId"];
    if (nil != cqId) {
        [titleArray enumerateObjectsUsingBlock:^(CityInfo * info, NSUInteger titleIdx, BOOL *stop) {
            __strong JJSChoseTableView * strongSelf = weakSelf;
            if ([info.snCode isEqualToString:cqId]) {
                titleIndexPath = [NSIndexPath indexPathForRow:titleIdx inSection:0];
                areaCity = [titleArray objectAtIndex:titleIdx];
                __block NSString* areaId = [_userInfo objectForKey:@"areaId"];
                    [strongSelf getPlaceInfoWith:info.snCode withFinish:^(BOOL finish) {
                        UITableView *tableView = (UITableView *)[strongSelf viewWithTag:6001];
                        [tableView reloadData];
                         if (nil != areaId) {
                            [subArray enumerateObjectsUsingBlock:^(CityInfo * subInfo, NSUInteger subTitleIdx, BOOL *subStop) {
                                if ([subInfo.snCode isEqualToString:areaId]) {
                                subTitleindexPath = [NSIndexPath indexPathForRow:subTitleIdx inSection:0];
                                *subStop = YES;
                                *stop = YES;
                                [strongSelf tableViewScrollToRow:titleIndexPath andTwoTableRow:subTitleindexPath];
                            }
                            }];
                         }else{
                             *stop = YES;
                             [strongSelf tableViewScrollToRow:titleIndexPath andTwoTableRow:subTitleindexPath];
                         }
                    }];
                
            }
        }];
    }
}

- (void)scrollChosePrice
{
    NSString * start = [_userInfo objectForKey:@"start"];
    NSString * end = [_userInfo objectForKey:@"end"];
    if (nil != start && nil != end) {
        __weak JJSChoseTableView * weakSelf = self;
        [titleArray enumerateObjectsUsingBlock:^(NSDictionary * title , NSUInteger idx, BOOL *stop) {
            __strong JJSChoseTableView * strongSelf = weakSelf;
            NSString * titleStart = [title objectForKey:@"start"];
            NSString * titleEnd = [title objectForKey:@"end"];
            if ([start isEqualToString:titleStart] && [end isEqualToString:titleEnd]) {
                [strongSelf tableViewScrollToRow:[NSIndexPath indexPathForRow:idx inSection:0] andTwoTableRow:nil];
            }
        }];
    }
}

- (void)scrollChoseMore
{
//    NSIndexSet * idxSet = [_userInfo objectForKey:@"moreIndexSet"];
//    [idxSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {

        NSInteger idx = [[_userInfo objectForKey:@"lastIndex"] integerValue];
        NSInteger row = [[_userInfo objectForKey:[NSString stringWithFormat:@"%ld",idx]] integerValue];
        UITableView *tableView = (UITableView *)[self viewWithTag:6000];
        [self tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
        [self tableViewScrollToRow:[NSIndexPath indexPathForRow:idx inSection:0] andTwoTableRow:[NSIndexPath indexPathForRow:row inSection:0]];
//    }];
}
- (void)getPlaceInfoWith:(NSString *)placeCode withFinish:(CompletionBlock)completion
{
    CityDao *dao = [[CityDao alloc] init];
    [dao getCityByParentCode:placeCode completion:^(BOOL finish, id obj) {
        [subArray removeAllObjects];
        subArray = [obj mutableCopy];
        CityInfo *city = [[CityInfo alloc] init];
        city.cityName = @"不限";
        city.snCode = nil;
        [subArray insertObject:city atIndex:0];
        if (completion) {
            completion(YES);
        }
    }];
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 6001) {
        return subArray.count;
    }
    return titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    [cell setSelectedBackgroundView:selectedBgView(cell.frame)];
    [cell.textLabel setFont:kContentFontMiddle];
    [cell.textLabel setTextColor:HexRGB(0x333333)];
    cell.textLabel.highlightedTextColor = HexRGB(0xfa0000);//cell选中时的颜色
    if (tableView.tag == 6000) {
        NSString *string = nil;
        switch (choseType) {
            case ChoseTypeClassification:
                string = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"title"];
                break;
            case ChoseTypeAreaInfo:
                string = [(CityInfo *)[titleArray objectAtIndex:indexPath.row] cityName];
                break;
            case ChoseTypePrice:
                string = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"price"];
                break;
            case ChoseTypeBuildArea:
                string = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"buildArea"];
                break;
            case ChoseTypeHouseType:
                string = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"housetype"];
                break;
            case ChoseTypeMore:
            {
                string = [titleArray objectAtIndex:indexPath.row];
            }
                break;
            default:
                break;
        }
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",string]];
    }else if (tableView.tag == 6001){
        if (choseType == ChoseTypeAreaInfo) {
            [cell.textLabel setText:[(CityInfo *)subArray[indexPath.row] cityName]];
            
        }else{
            NSString *string = nil;
            switch (moreIndex) {
                case 0:
                {
                    string = @"不限";
                }
                    break;
//                case 1:
//                {
//                    string = [subArray objectAtIndex:indexPath.row];
//                }
//                    break;
                case 1:
                {
                    string = [[subArray objectAtIndex:indexPath.row] objectForKey:@"buildArea"];
                }
                    break;
                case 2:
                {
                    string = [[subArray objectAtIndex:indexPath.row] objectForKey:@"housetype"];
                }
                    break;
                default:
                    break;
            }
            [cell.textLabel setText:[NSString stringWithFormat:@"%@",string]];
        }
//        NSIndexPath *indexPath0 = [NSIndexPath indexPathForRow:0 inSection:0];
//        [tableView selectRowAtIndexPath:indexPath0 animated:YES scrollPosition:UITableViewScrollPositionNone];
    }else{
    
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currentIndex == OneTableView) {
        if (self.ClickActionBlock) {
            NSString *string = nil;
            NSDictionary *titleDic;
            NSString *start = nil;
            NSString *end = nil;
            switch (choseType) {
                case ChoseTypeClassification:
                    titleDic = [titleArray objectAtIndex:indexPath.row];
//                    titleDic = @{@"title":string,@"type":[NSString stringWithFormat:@"%ld",(indexPath.row + 1)]};
                    break;
                case ChoseTypeAreaInfo:
                    string = [(CityInfo *)[titleArray objectAtIndex:indexPath.row] cityName];
                    titleDic = @{@"title":string};
                    break;
                case ChoseTypePrice:
                    string = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"price"];
                    start = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"start"];
                    end = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"end"];
                    titleDic = @{@"title":string,@"start":start,@"end":end};
                    break;
//                case ChoseTypeBuildArea:
//                    string = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"buildArea"];
//                    start = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"start"];
//                    end = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"end"];
//                    titleDic = @{@"title":string,@"start":start,@"end":end};
//                    
//                    break;
//                case ChoseTypeHouseType:
//                    string = [[titleArray objectAtIndex:indexPath.row] objectForKey:@"housetype"];
//                    titleDic = @{@"title":string,@"housetype":[NSString stringWithFormat:@"%ld",indexPath.row]};
//                    break;
                default:
                    break;
            }
//            NSDictionary *titleDic = @{@"title":string};
            self.ClickActionBlock(titleDic);
        }
    }else if (currentIndex == TwoTableView){
        if (choseType == ChoseTypeAreaInfo) {
            if (tableView.tag == 6000) {
                [self getPlaceInfoWith:[(CityInfo *)[titleArray objectAtIndex:indexPath.row] snCode] withFinish:nil];
                
                areaCity = [titleArray objectAtIndex:indexPath.row];
                
                UITableView *subTableView = (UITableView *)[self viewWithTag:6001];
                [subTableView reloadData];
                
            }else if (tableView.tag == 6001){
                
                NSString *string;
                NSString *snCode;
                if (indexPath.row) {
                    string  = [(CityInfo *)subArray[indexPath.row] cityName];
                    snCode = [(CityInfo *)subArray[indexPath.row] snCode];
                }else{
                    string = [areaCity cityName];
                    snCode = nil;
                }
                NSDictionary *titleDic = @{@"title":string};
                
                if (areaCity != nil && ![JJSUtil isBlankString:[areaCity snCode]]) {
                    titleDic = @{@"title":string,@"cqId":[areaCity snCode]};
                }
                if (![JJSUtil isBlankString:snCode]) {
                    titleDic = @{@"title":string,@"cqId":[areaCity snCode],@"areaId":snCode};
                }
                
                self.ClickActionBlock(titleDic);
                
            }else{
                
            }
        }else{
            if (tableView.tag == 6000) {
                moreIndex = indexPath.row; //2015-04-27
                switch (indexPath.row) {
                    case 0:
                        subArray = [@[@"不限"] mutableCopy];
                        break;
//                    case 1:
//                    {
//                        subArray = [@[@"不限",@"时间由近到远",@"价格由高到低"] mutableCopy];
//                    }
//                        break;
                    case 1:
                    {
                        subArray = [[JJSUtil arrayWithFileName:@"JJSBuildArea.plist"] mutableCopy];
                    }
                        break;
                    case 2:
                    {
                        subArray = [[JJSUtil arrayWithFileName:@"JJSHouseType.plist"] mutableCopy];
                    }
                        break;
                    default:
                        break;
                }
                UITableView *subTableView = (UITableView *)[self viewWithTag:6001];
                [subTableView reloadData];
                NSInteger lastSelect = [[_userInfo objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] integerValue];
                [self tableViewScrollToRow:nil andTwoTableRow:[NSIndexPath indexPathForRow:lastSelect inSection:0]];
            }else if (tableView.tag == 6001){
                
                NSString *string;
                NSMutableIndexSet * idxSet = [_userInfo objectForKey:@"moreIndexSet"];
                if (idxSet == nil) {
                    idxSet = [NSMutableIndexSet indexSet];
                }
                [idxSet addIndex:moreIndex];
                [_userInfo setValue:idxSet forKey:@"moreIndexSet"];
                [_userInfo setValue:[NSString stringWithFormat:@"%ld",moreIndex] forKey:@"lastIndex"];
                [_userInfo setValue:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:[NSString stringWithFormat:@"%ld",moreIndex]];
                switch (moreIndex) {
                    case 0:
                        string = subArray[indexPath.row];
                        
                        break;
//                    case 1:
//                    {
//                        string = subArray[indexPath.row];
//                        [params setValue:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"px"];
//                    }
//                        break;
                    case 1:
                    {
                        string = [subArray[indexPath.row] objectForKey:@"buildArea"];
                        [_userInfo setValue:[subArray[indexPath.row] objectForKey:@"start"] forKey:@"start"];
                        [_userInfo setValue:[subArray[indexPath.row] objectForKey:@"end"] forKey:@"end"];
                    }
                        break;
                    case 2:
                    {
                        string = [subArray[indexPath.row] objectForKey:@"housetype"];
                        [_userInfo setValue:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"housetype"];
                    }
                        break;
                    default:
                        break;
                }
                NSLog(@"string:%@",_userInfo);
            }
        }
    } else {
        
    }
}

- (void)czAction:(UIButton *)sender
{
    if (sender.tag == TAG_BUTTON) {
        [self resetInfo:sender];
        return;
    }
    if (self.ClickActionBlock) {
        self.ClickActionBlock(_userInfo);
    }
}

- (void) resetInfo:(UIButton *) sender
{
    NSIndexSet * idxSet = [_userInfo objectForKey:@"moreIndexSet"] ;
    [idxSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [_userInfo removeObjectForKey:[NSString stringWithFormat:@"%ld",idx]];
    }];
    [_userInfo removeObjectForKey:@"lastIndex"];
    [_userInfo removeObjectForKey:@"moreIndexSet"];
    [self scrollChoseMore];
//    [_userInfo removeAllObjects];
//    [_userInfo setValue:@"Yes" forKey:@"Reset"];
}

-(void) tableViewScrollToRow:(NSIndexPath *) oneIndex andTwoTableRow:(NSIndexPath *)twoIndex
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.1];
    dispatch_async(dispatch_get_main_queue(), ^{
        UITableView *tableView = (UITableView *)[self viewWithTag:6000];
        switch (currentIndex) {
            case OneTableView:
                [tableView selectRowAtIndexPath:oneIndex animated:NO scrollPosition:UITableViewScrollPositionTop];
                break;
            case TwoTableView:
            {
                UITableView *subTableView = (UITableView *)[self viewWithTag:6001];
                if (nil != oneIndex) {
                    [tableView selectRowAtIndexPath:oneIndex animated:NO scrollPosition:UITableViewScrollPositionTop];
                }
                if(nil != subTableView && nil != twoIndex)
                {
                    [subTableView selectRowAtIndexPath:twoIndex animated:NO scrollPosition:UITableViewScrollPositionTop];
                }
            }
                break;
            case ThreeTableView:
                break;
            default:
                break;
        }
    });
    });
}

@end
