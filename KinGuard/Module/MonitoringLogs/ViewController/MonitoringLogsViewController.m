//
//  MonitoringLogsViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/30.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "MonitoringLogsViewController.h"

@interface MonitoringLogsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *tableViewContent;
@end

@implementation MonitoringLogsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SegChange:(UISegmentedControl *)sender {
    sender.selectedSegmentIndex = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0;
    }
    return 15;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *clearView = [[UIView alloc] init];
    clearView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, CGRectGetWidth(tableView.frame), 0.5)];
    view.backgroundColor = HexRGB(0xB7B7B7);
    [clearView addSubview:view];
    return clearView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [JJSUtil setExtraCellLineHidden:tableView];
    return self.tableViewContent.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tableViewContent objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    LeftType type = [[[self.tableViewContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] integerValue];

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MonitoringCell"];
        return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    LeftType type = [[[self.tableViewContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] integerValue];
    
}

@end
