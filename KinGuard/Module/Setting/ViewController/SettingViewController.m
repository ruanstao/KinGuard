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
#import "AccountInfo.h"
#import "GuarderInfo.h"

@interface SettingViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *babyName;
@property (nonatomic, strong) UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *memberShip;

@property (nonatomic, strong) NSArray *pids; //所有设备
@property (nonatomic, strong) NSArray *info; //所有监护人信息

@property (nonatomic, strong) NSMutableArray *memberInfo;//
@property (nonatomic, strong) GuarderInfo *currentMemInfo;//
@property (nonatomic, assign) NSInteger currentMemIndex;

@property (nonatomic, strong) DeviceInfo *currentDeviceInfo;
@property (nonatomic, assign) NSInteger currentIndex;//当前选择的宝贝指针

@property (nonatomic, strong) AccountInfo *accountInfo;
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
    
    self.memberInfo = [NSMutableArray array];
    [self requestData];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestData
{
    [self getUserInfoFinish:^{
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
                            [self refreshUI];
                        }
                    }];
                }
            }
        } fail:^(NSString *error) {
            NSLog(@"%@",error);
        }];
    }];
}

- (void)requestDeviceInfo:(NSString *)pid finish:(void (^)(DeviceInfo *info))block
{

//    c202237b
    [[KinDeviceApi sharedKinDevice] deviceInfoPid:@"c202237b"//pid
                                          success:^(NSDictionary *devicedata) {

        NSLog(@"%@",devicedata);
        [[KinDeviceApi sharedKinDevice] deviceBindInfoPid:@"c202237b" success:^(NSDictionary *data) {
            NSLog(@"baby:%@",data);
            if ([data isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)data;
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    GuarderInfo *info = [GuarderInfo mj_objectWithKeyValues:obj];
                    [self.memberInfo addObject:info];
                }];
            }
            if (block) {
                block([DeviceInfo mj_objectWithKeyValues:devicedata]);
            }
        } fail:^(NSString *error) {
                                                  
        }];
        
                                              
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
    
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

- (void)refreshUI
{
    self.currentDeviceInfo = [self.info objectAtIndex:self.currentIndex];
    self.currentMemInfo = [self.memberInfo objectAtIndex:self.currentMemIndex];
    [self.tableView reloadData];
    
}

#pragma mark <UITableViewDataSource,UITableViewDelegate>

//akey = 6ce68d05;
//"asset_id" = c202237b;
//"asset_name" = "星聯守護";
//qrcode = 042bd75cb0bf4cdcad4d77038baec47e3ec5;
//"qsc_ver" = "1.2.19";
//sex = F;
//"wifi_ver" = "1.3.0";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                //星宝宝
               self.babyName.text = self.currentMemInfo.acc_name;
            }
                break;
            case 1:{
                //我是宝贝的XX
                if (![JJSUtil isBlankString:self.currentMemInfo.relationship]) {
                    self.memberShip.text = self.currentMemInfo.relationship;
                }
                
            }
                break;
            case 2:{
                //设备二维码

            }
                break;
            case 3:{
                //远程关机
            }
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                //声音开关
            }
                break;
            case 1:{
                //震动
            }
                break;
            case 2:{
                //轨迹连线
            }
                break;
            case 3:{
                //接触绑定
            }
                break;
                
            default:
                break;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                //星宝宝
            }
                break;
            case 1:{
                //关系设置 //我是宝贝的XX
                MemberShipViewController *memberController = [[MemberShipViewController alloc] initWithNibName:@"MemberShipViewController" bundle:nil];
                memberController.type = FromType_Setting;
                [self.navigationController pushViewController:memberController animated:YES];
            }
                break;
            case 2:{
                //设备二维码
                QRCodeViewController *memberController = [[QRCodeViewController alloc] initWithNibName:@"QRCodeViewController" bundle:nil];
                memberController.info = self.currentDeviceInfo;
                [self.navigationController pushViewController:memberController animated:YES];
            }
                break;
            case 3:{
                //远程关机
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否确认远程关机？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
            }
                break;
                
            default:
                break;
        }
    }else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:{
                //声音开关
            }
                break;
            case 1:{
                //震动
            }
                break;
            case 2:{
                //轨迹连线
            }
                break;
            case 3:{
                //解除绑定
            }
                break;
                
            default:
                break;
        }
    }
}
- (IBAction)previous:(id)sender {
    self.currentIndex --;
    if (self.currentIndex < 0) {
        self.currentIndex = self.info.count - 1;
    }
    self.currentMemIndex --;
    if (self.currentMemIndex < 0) {
        self.currentMemIndex = self.memberInfo.count - 1;
    }
    [self refreshUI];
}
- (IBAction)next:(id)sender {
    self.currentIndex ++;
    if (self.currentIndex > self.info.count - 1) {
        self.currentIndex = 0;
    }
    self.currentMemIndex ++;
    if (self.currentMemIndex > self.memberInfo.count - 1) {
        self.currentMemIndex = 0;
    }
    [self refreshUI];
}
//声音
- (IBAction)isTurnOffSound:(id)sender {
    
}
//振动
- (IBAction)isTurnOffVibrate:(id)sender {
    
}
//轨迹连线
- (IBAction)isTrackConnection:(id)sender {
    
}

//解除绑定
- (IBAction)unlockBind:(id)sender {
    //akey = 6ce68d05;
    //"asset_id" = c202237b;
    __weak typeof(self) weakSelf = self;
    [[KinDeviceApi sharedKinDevice] unBindDeviceByPid:self.currentDeviceInfo.asset_id withKey:self.currentDeviceInfo.akey withMainacc:self.accountInfo.acc success:^(NSDictionary *data) {
        if ([[data objectForKey:@"state"] integerValue] == 0) {
            [weakSelf logout:nil];
        }else{
            [JJSUtil showHUDWithMessage:@"解绑失败" autoHide:YES];
        }
    } fail:^(NSString *error) {
        [JJSUtil showHUDWithMessage:error autoHide:YES];
    }];
}

- (IBAction)logout:(id)sender
{
    [[KinGuartApi sharedKinGuard] loginOutWithMobile:self.accountInfo.acc success:^(NSDictionary *data) {
        [JJSUtil showHUDWithMessage:@"退出成功" autoHide:YES];
        
        self.view.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
    } fail:^(NSString *error) {
        NSLog(@"logOut:%@",error);
    }];
}

//获取用户数据
- (void)getUserInfoFinish:(void (^)())block
{
    [[KinGuartApi sharedKinGuard] getUserInfoSuccess:^(NSDictionary *data) {
        NSLog(@"userInfo:%@",data);
        self.accountInfo = [AccountInfo mj_objectWithKeyValues:data];
        block();
    } fail:^(NSString *error) {
        NSLog(@"error:%@",error);
        [JJSUtil showHUDWithMessage:@"用户信息获取失败" autoHide:YES];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        //
        [JJSUtil showHUDWithMessage:@"无接口" autoHide:YES];
    }
}

@end
