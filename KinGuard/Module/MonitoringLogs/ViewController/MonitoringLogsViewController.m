//
//  MonitoringLogsViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/30.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "MonitoringLogsViewController.h"
#import "LocationHistroyModel.h"

@interface MonitoringLogsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *tableViewContent;

@property (nonatomic, strong) NSMutableArray *systemContent;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation MonitoringLogsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.tableViewContent = [NSMutableArray array];
    [self getdata];
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
    
    self.selectIndex = sender.selectedSegmentIndex;
    [self.tableView reloadData];
}

- (void)getdata
{
    NSDate *senddate = [NSDate date];
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    //结束时间
    NSString *endDate = [[dateformatter stringFromDate:senddate] stringByAppendingString:@"T24:00:00"];
    
    //开始时间
    NSTimeInterval time = 30 * 24 * 60 * 60;//一年的秒数
    NSDate * lastMonth = [senddate dateByAddingTimeInterval:-time];
    //转化为字符串
    NSString * startDate = [[dateformatter stringFromDate:lastMonth] stringByAppendingString:@"T00:00:00"];
    
    NSString *pid = [[NSUserDefaults standardUserDefaults] objectForKey:KinGuard_Device];
    
//    [[KinLocationApi sharedKinLocation] readLocationInfo:pid success:^(NSDictionary *data) {
//        NSLog(@"%@",data);
//        [[KinLocationApi sharedKinLocation] getLocationByPid:pid withLocationToken:[data objectForKey:@"token"] success:^(NSDictionary *data) {
//            NSLog(@"%@",data);
//        } fail:^(NSString *error) {
//            
//        }];
//    } fail:^(NSString *error) {
//        
//    }];
    
    [[KinLocationApi sharedKinLocation] readPosHisInfo:pid withBegdt:startDate withEnddt:endDate success:^(NSDictionary *data) {
        NSLog(@"device data:%@",data);
        NSArray *array = (NSArray *)data;
        self.systemContent = [array mutableCopy];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LocationHistroyModel *model = [LocationHistroyModel mj_objectWithKeyValues:obj];
            [self.tableViewContent addObject:model];
        }];
        [self.tableView reloadData];
    } fail:^(NSString *error) {
        NSLog(@"device data:%@",error);
        [JJSUtil showHUDWithMessage:error autoHide:YES];
    }];
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
    if (self.selectIndex == 0) {
        return self.tableViewContent.count;
    }
    return self.systemContent.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;//[[self.tableViewContent objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.selectIndex == 0) {
        return 44;
    }
    return 240;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    LeftType type = [[[self.tableViewContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] integerValue];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (self.selectIndex == 0) {
        LocationHistroyModel *model = [self.tableViewContent objectAtIndex:indexPath.section];
        [cell.textLabel setText:model.location_m];
        [cell.detailTextLabel setText:model.addr];
    }else{
        NSDictionary *body = [self.systemContent objectAtIndex:indexPath.section];
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [cell.textLabel setText:jsonString];
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.text = @"";
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    LeftType type = [[[self.tableViewContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] integerValue];
    
}

@end
