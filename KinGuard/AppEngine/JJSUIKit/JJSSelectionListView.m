//
//  JJSSelectionListView.m
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/9.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "JJSSelectionListView.h"
#import "JJSTableViewCell.h"
#import "SelectTitleModels.h"

@implementation JJSSelectionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:kWhiteColor];
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
    if ([self.delegate respondsToSelector:@selector(cancelSelectionListView)]) {
        [self.delegate cancelSelectionListView];
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id model = [self.inputDataSource objectAtIndex:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:value:name:)]) {
//        [self.delegate didSelectRowAtIndexPath:indexPath.row value:model.value name:model.name];
        [self.delegate didSelectRowAtIndexPath:indexPath.row value:[[model valueForKey:@"value"] integerValue] name:[model valueForKey:@"name"]];
    }
    if ([self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:value:name:otherParams:)]) {

        [self.delegate didSelectRowAtIndexPath:indexPath.row value:[[model valueForKey:@"value"] integerValue] name:[model valueForKey:@"name"] otherParams:[model otherParams]];
    }
}

@end
