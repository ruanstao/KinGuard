//
//  JJSMutilSelectionListView.m
//  JJSOA
//
//  Created by RuanSTao on 16/4/21.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSMutilSelectionListView.h"
#import "JJSTableViewCell.h"
#import "SelectTitleModels.h"

@interface JJSMutilSelectionListView ()

@property (nonatomic,strong) NSMutableIndexSet *indexSet; //保存选择信息

@end

@implementation JJSMutilSelectionListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:kWhiteColor];
        self.indexSet = [NSMutableIndexSet indexSet];
    }
    return self;
}

- (void)listViewWithTitle:(NSString *)title
{
    // Tool bar view
    UIView *toolBarView = [[UIView alloc] initWithFrame:(CGRect){0, 0, mScreenWidth, 40}];
    [toolBarView setBackgroundColor:[UIColor colorWithRed:0.941 green:0.937 blue:0.957 alpha:1]];
    [toolBarView addSubview:[JJSUtil getSeparator:kSeparatorColor frame:(CGRect){0, 39, mScreenWidth, 1}]];
    [self addSubview:toolBarView];

    // Cancel button
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancel setFrame:(CGRect){10, 5, 48, 30}];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:kNavItemColor forState:UIControlStateNormal];
    [btnCancel setTitleColor:kTableViewCellDetailLabelTextColor forState:UIControlStateHighlighted];
    [btnCancel.titleLabel setFont:kContentFont];
    [btnCancel addTarget:self action:@selector(cancelInputPickerView) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:btnCancel];

    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setFrame:(CGRect){mScreenWidth - 60, 5, 48, 30}];
    [btnDone setTitle:@"确定" forState:UIControlStateNormal];
    [btnDone setTitleColor:kNavItemColor forState:UIControlStateNormal];
    [btnDone setTitleColor:kTableViewCellDetailLabelTextColor forState:UIControlStateHighlighted];
    [btnDone.titleLabel setFont:kContentFont];
    [btnDone addTarget:self action:@selector(doneInputPickerView) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:btnDone];

    UILabel *labTitle = [[UILabel alloc] initWithFrame:(CGRect){80, 10, mScreenWidth - 160, 20}];
    [labTitle setText:title];
    [labTitle setTextColor:kTableViewCellDetailLabelTextColor];
    [labTitle setTextAlignment:NSTextAlignmentCenter];
    [labTitle setFont:kTitleFontSec];
    [toolBarView addSubview:labTitle];

    UITableView *inputTableView = [[UITableView alloc] initWithFrame:(CGRect){0, 40, mScreenWidth, 220} style:UITableViewStylePlain];
    [inputTableView setDelegate:self];
    [inputTableView setDataSource:self];
    [inputTableView setShowsVerticalScrollIndicator:NO];
    [JJSUtil setExtraCellLineHidden:inputTableView];
    [self addSubview:inputTableView];

    [UIView animateWithDuration:0.3f animations:^{

        [self setFrame:(CGRect){0, mScreenHeight - 260, mScreenWidth, 260}];

    }];

}

- (void)cancelInputPickerView
{
    if (self.cancelSelectionListView) {
        self.cancelSelectionListView();
    }
}

- (void)doneInputPickerView
{
    NSMutableArray *array = [NSMutableArray array];
    [self.indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:self.inputDataSource[idx]];
    }];
    if (self.doneSelectionListView) {
        self.doneSelectionListView(array);
    }
}


#pragma mark UITableView DataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.inputDataSource count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // for ios 7
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // for ios8
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"selectListCell";
    JJSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[JJSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //    DictionaryModel *model = [self.inputDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.inputDataSource[indexPath.row] valueForKey:@"name"];
    if ([self.indexSet containsIndex:indexPath.row]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.indexSet containsIndex:indexPath.row]) {
        [self.indexSet removeIndex:indexPath.row];
    }else{
        [self.indexSet addIndex:indexPath.row];
    }
    id model = [self.inputDataSource objectAtIndex:indexPath.row];

    if (self.didSelectRowAtIndexPath_Value_Name) {
        self.didSelectRowAtIndexPath_Value_Name(indexPath.row,[[model valueForKey:@"value"] integerValue],[model valueForKey:@"name"]);
    }
    if (self.didSelectRowAtIndexPath_Value_Name_OtherParams) {
        self.didSelectRowAtIndexPath_Value_Name_OtherParams(indexPath.row,[[model valueForKey:@"value"] integerValue],[model valueForKey:@"name"],[model otherParams]);
    }
    [tableView reloadData];
}
@end
