//
//  MemberListViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "MemberListViewController.h"
#import "MemberListCell.h"
#import "GuarderInfo.h"

@interface MemberListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *memberListTableView;
@property (nonatomic, strong) NSArray *pids; //所有设备
@property (nonatomic, strong) NSArray *info; //所有监护人信息

@end

@implementation MemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:124/255.0 blue:195/255.0 alpha:1];
    
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:239/255.0 alpha:1];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"topbtn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self. navigationItem.leftBarButtonItem = leftItem;
    
    [self initilizeBaseView];
    [self getMemerInfo];
}

- (void)initilizeBaseView
{
    self.memberListTableView.delegate = self;
    self.memberListTableView.dataSource = self;
    self.memberListTableView.tableFooterView = [UIView new];
    self.memberListTableView.backgroundColor = [UIColor colorWithRed:244/255.0 green:243/255.0 blue:239/255.0 alpha:1];
}

- (void)getMemerInfo
{
    [[KinDeviceApi sharedKinDevice] deviceListSuccess:^(NSDictionary *data) {
        NSLog(@"%@",data);
        self.pids = @[[data objectForKey:@"pids"]?:@[]];
        [self requestDeviceInfoFinish:^(NSArray *info) {
            self.info = info;
            NSLog(@"kkk:%@",self.info);
            [self.memberListTableView reloadData];
        }];
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestDeviceInfoFinish:(void (^)(NSArray *info))block
{
    if (self.pids.count > 0) {
        NSMutableArray *infoArr = [NSMutableArray array];
        for (int i = 0;i < self.pids.count;i++) {
            NSString *pid = [self.pids objectAtIndex:i];
            [[KinDeviceApi sharedKinDevice] deviceBindInfoPid:pid success:^(NSDictionary *data) {
                NSLog(@"---:%@",data);
                if ([data isKindOfClass:[NSArray class]]) {
                    NSArray *array = (NSArray *)data;
                    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        GuarderInfo *guarder = [GuarderInfo mj_objectWithKeyValues:obj];
                        [infoArr addObject:guarder];
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

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.info.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberListCell *cell = [MemberListCell cellForTableView:tableView];
    GuarderInfo *guarder = [self.info objectAtIndex:indexPath.row];
    [cell.labName setText:guarder.aliasname];
    [cell.labPhone setText:guarder.acc];
    return cell;
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
