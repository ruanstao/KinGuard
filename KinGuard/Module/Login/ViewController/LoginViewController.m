//
//  LoginViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/4.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "UserModel.h"
#import "BindDeviceViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = nil;
}

- (IBAction)login:(id)sender {
    
    NSString *phone = self.usernameField.text;
    NSString *pwd = self.passwordField.text;
    
    if ([JJSUtil isBlankString:phone]) {
        [JJSUtil showHUDWithMessage:@"请输入手机号码" autoHide:YES];
        return;
    }
    if ([JJSUtil isBlankString:pwd]) {
        [JJSUtil showHUDWithMessage:@"请输入密码" autoHide:YES];
        return;
    }
    [[KinGuartApi sharedKinGuard] loginWithMobile:phone withPassword:pwd success:^(NSDictionary *data) {
        [JJSUtil hideHUD];
//        [JJSUtil showHUDWithMessage:@"登陆成功" autoHide:YES];
        
        //存储登录信息
        UserModel *model = [[UserModel alloc] init];
        model.username = phone;
        model.password = pwd;
        model.token = [data objectForKey:@"logintoken"];
        
        //判断是否已经绑定设备
        [[KinDeviceApi sharedKinDevice] deviceListSuccess:^(NSDictionary *data) {
            NSLog(@"%@",data);
            if (![JJSUtil isBlankString:[data objectForKey:@"pids"]]) {
                
                model.isLogined = YES;
                NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:model];
                [JJSUtil storageDataWithObject:userData Key:KinGuard_UserInfo Completion:^(BOOL finish, id obj) {
                    
                    //注册别名推送
                    [JPUSHService setAlias:model.username callbackSelector:nil object:nil];
                    
                    //跳转到主界面
                    ViewController *viewController = [[ViewController alloc] init];
                    self.view.window.rootViewController = viewController;
                }];
            }else{
                model.isLogined = NO;
                
                NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:model];
                [JJSUtil storageDataWithObject:userData Key:KinGuard_UserInfo Completion:^(BOOL finish, id obj) {
                    //跳转到绑定设备页面
                    BindDeviceViewController *bindController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"BindController"];
                    [self.navigationController pushViewController:bindController animated:YES];
                }];
                
            }
         
         } fail:^(NSString *error) {
             NSLog(@"%@",error);
             [JJSUtil showHUDWithMessage:@"获取绑定设备信息失败，请重新点击登录" autoHide:YES];
         }];
        
    } fail:^(NSString *error) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:error autoHide:YES];
    }];
}

- (IBAction)forget:(id)sender {
    NSString *phone = self.usernameField.text;
    if (phone.length < 11 || [JJSUtil isBlankString:phone]) {
        [JJSUtil showHUDWithMessage:@"请输入正确的手机号码" autoHide:YES];
        return;
    }
    ForgetViewController *forgetController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ForgetViewController"];
    forgetController.phone = phone;
    [self.navigationController pushViewController:forgetController animated:YES];
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
- (IBAction)backAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
