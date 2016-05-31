//
//  BindDeviceViewController.m
//  邦邦熊
//
//  Created by 莫菲 on 16/2/24.
//  Copyright © 2016年 linktop. All rights reserved.
//

#import "BindDeviceViewController.h"
#import "XDScaningViewController.h"
#import "UIImage+IAnime.h"
#import "FollowViewController.h"
#import "MemberShipViewController.h"

@interface BindDeviceViewController ()<UIAlertViewDelegate>
/**
 *  如何获取ID和安全码的提示
 */
@property (weak, nonatomic) IBOutlet UILabel *getTipsLabel;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;
@property (weak, nonatomic) IBOutlet UIView *bindView;
//
/*二维码添加
 */
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
//
/*设备ID添加
 */
@property (weak, nonatomic) IBOutlet UIButton *idCodeBtn;
/**
 *  设备ID输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *deviceIdField;
/**
 *  安全吗输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *safeCodeField;

@property (nonatomic, copy) NSString *qrcode;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *akey;

@end

@implementation BindDeviceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加设备";
    _bindBtn.layer.cornerRadius=5;
    _bindBtn.layer.masksToBounds=YES;
    
    //设置选中未选中状态下 按钮的背景色和字体颜色
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_codeBtn setBackgroundImage:[UIImage initWithColor:[UIColor blackColor] rect:_codeBtn.frame] forState:UIControlStateSelected];
    [_codeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_codeBtn setBackgroundImage:[UIImage initWithColor:Main_Color rect:_codeBtn.frame] forState:UIControlStateNormal];
    
    [_idCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_idCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_idCodeBtn setBackgroundImage:[UIImage initWithColor:[UIColor blackColor] rect:_codeBtn.frame] forState:UIControlStateSelected];
    [_idCodeBtn setBackgroundImage:[UIImage initWithColor:Main_Color rect:_codeBtn.frame] forState:UIControlStateNormal];
    //默认选中二维码扫描
    [_codeBtn setSelected:YES];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:124/255.0 blue:195/255.0 alpha:1];
    
    [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back
{
    if (self.fromType == TransType_FromHomePage) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
/**
 *  如何获得设备ID和安全码
 *
 */
- (IBAction)howToGetIdAndSafeCode:(id)sender {
    [_getTipsLabel setHidden:NO];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}
/**
 *  ID添加
 */
- (IBAction)addFromDeviceId:(id)sender {
    _bindView.hidden=NO;
    [_idCodeBtn setSelected:YES];
    [_codeBtn setSelected:NO];
}
/**
 *  二维码添加
 */
- (IBAction)addFrom2Dcode:(id)sender {
    [_codeBtn setSelected:YES];
    [_idCodeBtn setSelected:NO];
    _bindView.hidden=YES;
}
/**
 *  二维码扫描
 */
- (IBAction)shaoMiao2DCode:(id)sender {
    //初始化相机控制器
    XDScaningViewController* scanVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XDScaningVC"];
    [scanVC setBackValue:^(NSString * qr_code) {
        [JJSUtil showHUDWithWaitingMessage:@"绑定中..."];
        
        [[KinDeviceApi sharedKinDevice] bindDeviceByQRCode:qr_code success:^(NSDictionary *data) {
            NSLog(@"%@",data);
            [JJSUtil hideHUD];
            //被别人绑定之后
            if ([data objectForKey:@"state"] && [[data objectForKey:@"state"] integerValue] == 2) {
                self.qrcode = qr_code;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否关注设备？" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                [alertView setTag:1];
                [alertView show];
                
            }else{
                [JJSUtil showHUDWithMessage:@"绑定成功" autoHide:YES];
                //跳转到关系设定页面
                MemberShipViewController *memberController = [[MemberShipViewController alloc] initWithNibName:@"MemberShipViewController" bundle:nil];
                memberController.type = FromType_Login;
                [self.navigationController pushViewController:memberController animated:YES];
            }
        } fail:^(NSString *error) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:error autoHide:YES];
        }];
    }];
    //弹出系统照相机，全屏拍摄
    [self presentViewController:scanVC animated:YES completion:nil];
}
/**
 *  ID激活并绑定
 */
- (IBAction)bindDevice:(id)sender {
    
    NSString *pid = self.deviceIdField.text;
    NSString *savecode = self.safeCodeField.text;
    
    [[KinDeviceApi sharedKinDevice] bindDeviceByPid:pid withKey:savecode success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        [JJSUtil hideHUD];
        //被别人绑定之后
        if ([data objectForKey:@"state"] && [[data objectForKey:@"state"] integerValue] == 2) {
            self.pid = pid;
            self.akey = savecode;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"是否关注设备？" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            [alertView setTag:2];
            [alertView show];
            
        }else{
            [JJSUtil showHUDWithMessage:@"绑定成功" autoHide:YES];
            //跳转到关系设定页面
            MemberShipViewController *memberController = [[MemberShipViewController alloc] initWithNibName:@"MemberShipViewController" bundle:nil];
            memberController.type = FromType_Login;
            [self.navigationController pushViewController:memberController animated:YES];
        }
    } fail:^(NSString *error) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:error autoHide:YES];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        
        //跳转关注页面
        FollowViewController *followController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FollowVC"];
        if (alertView.tag == 1) {
            followController.type = BindType_QRCode;
            followController.qrcode = self.qrcode;
        }else{
            followController.type = BindType_Pid;
            followController.pid = self.pid;
            followController.akey = self.akey;
        }
        [self.navigationController pushViewController:followController animated:YES];
    }
}

@end
