//
//  SettingViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/12.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "SettingViewController.h"
#import "DeviceInfo.h"
#import "MemberShipViewController.h"
#import "QRCodeViewController.h"

@interface SettingViewController ()

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) NSArray *pids; //所有设备
@property (nonatomic, strong) NSArray *info; //所有监护人信息

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:124/255.0 blue:195/255.0 alpha:1];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(0, 0, 23, 23);
    self.backBtn.contentHorizontalAlignment = UIViewContentModeLeft;
    [self.backBtn setTitle:@"返回" forState:UIControlStateNormal];
    
    // Replace backItem with real back button image
    [self.backBtn setImage:[UIImage imageNamed:@"topbtn_back"] forState:UIControlStateNormal];
    [self.backBtn setTitleColor:kBtnTitleNormalColor forState:UIControlStateNormal];
    self.backBtn.titleLabel.font = [UIFont systemFontOfSize:0];
    self.backBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.backBtn.showsTouchWhenHighlighted = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    
    [self requestData];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestData
{
    [[KinDeviceApi sharedKinDevice] deviceListSuccess:^(NSDictionary *data) {
        NSLog(@"%@",data);
        self.pids = @[[data objectForKey:@"pids"]?:@[]];
        if (self.pids.count> 0) {
            NSMutableArray *infoArr = [NSMutableArray array];
            for (NSString *pid in self.pids) {
                [self requestDeviceInfo:pid finish:^(DeviceInfo *info) {
                    [infoArr addObject:info];
                    if (infoArr.count == self.pids.count) {
                        self.info = infoArr;
                        
                    }
                }];
            }
        }
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestDeviceInfo:(NSString *)pid finish:(void (^)(DeviceInfo *info))block
{
    [[KinDeviceApi sharedKinDevice] deviceInfoPid:@"c202237b" success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        if (block) {
            block([DeviceInfo mj_objectWithKeyValues:data]);
        }
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%d",indexPath.row);
    switch (indexPath.row) {
        case 1:
        {
            //关系设置
            MemberShipViewController *memberController = [[MemberShipViewController alloc] initWithNibName:@"MemberShipViewController" bundle:nil];
            [self.navigationController pushViewController:memberController animated:YES];
        }
            break;
        case 2:
        {
            //二维码
            QRCodeViewController *memberController = [[QRCodeViewController alloc] initWithNibName:@"QRCodeViewController" bundle:nil];
            [self.navigationController pushViewController:memberController animated:YES];
            
        }
            break;
        default:
            break;
    }
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
