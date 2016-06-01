//
//  ElectronicViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/17.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "ElectronicViewController.h"
#import "SafeZoneModel.h"
#import "SafeTableViewCell.h"
#import "SafeZoneViewController.h"

@interface ElectronicViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *pids;  // pids 数组

@property (nonatomic,strong) NSArray *safeInfo; //所有安全区域

@property (nonatomic,strong) UITableView *safeTableView;

@end

@implementation ElectronicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"电子围栏";
    self.navigationItem.leftBarButtonItem = nil;
    
    [self initilizaBaseView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)initilizaBaseView
{
    self.safeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight - 49) style:UITableViewStylePlain];
    self.safeTableView.dataSource = self;
    self.safeTableView.delegate = self;
    self.safeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.safeTableView.tableFooterView = [UIView new];
    self.safeTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    [self.view addSubview:self.safeTableView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setFrame:CGRectMake(30, mScreenHeight - 44 - 20 - 49, mScreenWidth - 60, 44)];
    [addButton setTitle:@"添加（最多五个）" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor colorWithRed:0 green:124/255.0 blue:195/255.0 alpha:1]];
    [addButton.layer setCornerRadius:5];
    [addButton addTarget:self action:@selector(addSafeZone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}

- (void)requestData
{
    [[KinDeviceApi sharedKinDevice] deviceListSuccess:^(NSDictionary *data) {
        NSLog(@"%@",data);
        self.pids = @[[data objectForKey:@"pids"]?:@[]];
        if (self.pids.count > 0) {
            
            [self requestSafeZoneInfoFinish:^(NSArray *info) {
                self.safeInfo = info;
                NSLog(@"kkk:%@",self.safeInfo);
                [self.safeTableView reloadData];
            }];
            
        }
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestSafeZoneInfoFinish:(void (^)(NSArray *info))block
{
    if (self.pids.count > 0) {
        NSMutableArray *infoArr = [NSMutableArray array];
        for (int i = 0;i < self.pids.count;i++) {
            NSString *pid = @"c202237b";//[self.pids objectAtIndex:i];
            [[KinLocationApi sharedKinLocation] getSecZonePid:pid success:^(NSDictionary *data) {
                NSLog(@"---:%@",data);
                if ([data isKindOfClass:[NSArray class]]) {
                    NSArray *array = (NSArray *)data;
                    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        SafeZoneModel *safeModel = [SafeZoneModel mj_objectWithKeyValues:obj];
                        if (![JJSUtil isBlankString:safeModel.latitude] && ![JJSUtil isBlankString:safeModel.longitude]) {
                            [infoArr addObject:safeModel];
                        }
                    }];
                }
                if (i == self.pids.count - 1) {
                    if (block) {
                        block(infoArr);
                    }
                }
            } fail:^(NSString *error) {
                NSLog(@"%@",error);
            }];
        }
    }
}

#pragma mark ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.safeInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SafeTableViewCell *cell = [SafeTableViewCell cellForTableView:tableView];
    SafeZoneModel *safeModel = [self.safeInfo objectAtIndex:indexPath.row];
    [cell.labTitle setText:safeModel.alias];
    [cell.labAddress setText:safeModel.addr];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.safeInfo removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SafeZoneModel *safeModel = [self.safeInfo objectAtIndex:indexPath.row];
    SafeZoneViewController *safeController = [[SafeZoneViewController alloc] init];
    safeController.safeModel = safeModel;
    safeController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:safeController animated:YES];
}

- (void)addSafeZone:(id)sender
{
    //跳转到添加安全区域界面
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
