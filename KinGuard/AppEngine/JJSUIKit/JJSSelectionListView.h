//
//  JJSSelectionListView.h
//  JJSOA
//
//  Created by YD-Yanglijuan on 16/1/9.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJSSelectionListView;

@protocol JJSSelectionListViewDelegate <NSObject>

/**
 *  取消按钮点击事件
 */
- (void)cancelSelectionListView;

/**
 *  选择某一行的代理
 *
 *  @param row   选择了哪一行
 *  @param value 所选择的行对应的value值
 *  @param name  所选择行对应的name值
 */
@optional
- (void)didSelectRowAtIndexPath:(NSInteger)row value:(NSInteger)value name:(NSString *)name;

- (void)didSelectRowAtIndexPath:(NSInteger)row value:(NSInteger)value name:(NSString *)name otherParams:(NSDictionary *)otherParams;

@end

@interface JJSSelectionListView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign) id <JJSSelectionListViewDelegate> delegate;


@property (nonatomic,strong) NSArray *inputDataSource;
/**
 *  初始化控件
 *
 *  @param title 标题
 */
- (void)listViewWithTitle:(NSString *)title;

/**
 *  取消按钮点击事件
 */
- (void)cancelInputPickerView;

@end




//实例
/*
- (void)initSelectionListViewWithData:(NSArray *)array
{
    [self showAlphaBackgroundView:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelInputPickerView)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [[self alphaBackgroundView] addGestureRecognizer:tap];
    
    //初始化弹出列表
    self.listView = [[JJSSelectionListView alloc] initWithFrame:CGRectMake(0, mScreenHeight, mScreenWidth, 260)];
    [self.listView listViewWithTitle:self.selectionListTitle];
    self.listView.inputDataSource = array;
    self.listView.delegate = self;
    [self.navigationController.view addSubview:self.listView];
}

- (void)cancelInputPickerView
{
    [self cancelSelectionListView];
}

#pragma mark -弹出的列表选项代理
- (void)cancelSelectionListView
{
    [self hideAlphaBackgroundView:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.listView setFrame:(CGRect){0, mScreenHeight, mScreenWidth, 260}];
        
    } completion:^(BOOL finished) {
        [[self.listView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [obj removeFromSuperview];
        }];
        [self.listView removeFromSuperview];
        
    }];
}

- (void)didSelectRowAtIndexPath:(NSInteger)row value:(NSInteger)value name:(NSString *)name
{
    [self cancelSelectionListView];
    switch(self.currentRow) {
        case 0:
            [self.detailDict setObject:name forKey:@"source"];
            [self.updateDict setObject:@(value) forKey:@"source"];
            break;
        case 1:
            [self.detailDict setObject:name forKey:@"seeMode"];
            [self.updateDict setObject:@(value) forKey:@"seeMode.value"];
            break;
        case 2:
            [self.detailDict setObject:name forKey:@"fitment"];
            [self.updateDict setObject:@(value) forKey:@"fitment.value"];
            break;
        case 3:
            [self.detailDict setObject:name forKey:@"presentStatus"];
            [self.updateDict setObject:@(value) forKey:@"presentStatus.value"];
            break;
        case 4:
            [self.detailDict setObject:name forKey:@"rightType"];
            [self.updateDict setObject:@(value) forKey:@"rightType.value"];
            break;
            
        default:
            break;
    }
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentRow inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
}

*/