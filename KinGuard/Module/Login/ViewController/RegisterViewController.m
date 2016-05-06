//
//  RegisterViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/4.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "RegisterViewController.h"
#import "JKCountDownButton.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField1;
@property (weak, nonatomic) IBOutlet UITextField *pwdField2;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)getCode:(JKCountDownButton *)sender
{
    NSString *phone = self.usernameField.text;
    if ([JJSUtil isBlankString:phone]) {
        [JJSUtil showHUDWithMessage:@"请输入手机号码" autoHide:YES];
        return;
    }
    
    [JJSUtil showHUDWithWaitingMessage:@"正在发送验证码..."];
    [[KinGuartApi sharedKinGuard] catchSmsCodeWithMobile:phone withSmstype:@"0" success:^(NSDictionary *data) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:@"发送成功" autoHide:YES];
        
        //按钮处理
        sender.enabled = NO;
        //button type要 设置成custom 否则会闪动
        [sender startWithSecond:60];
        
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"点击重新获取";
            
        }];
        
    } fail:^(NSString *error) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:error autoHide:YES];
    }];
}

- (IBAction)regist:(id)sender
{
    NSString *phone = self.usernameField.text;
    NSString *pwd1 = self.pwdField1.text;
    NSString *pwd2 = self.pwdField2.text;
    NSString *code = self.codeField.text;
    
    if ([JJSUtil isBlankString:phone]) {
        [JJSUtil showHUDWithMessage:@"请输入手机号码" autoHide:YES];
        return;
    }
    if ([JJSUtil isBlankString:pwd1]) {
        [JJSUtil showHUDWithMessage:@"请输入密码" autoHide:YES];
        return;
    }
    if (![pwd1 isEqualToString:pwd2]) {
        [JJSUtil showHUDWithMessage:@"两次密码输入不一致" autoHide:YES];
        return;
    }
    if ([JJSUtil isBlankString:code]) {
        [JJSUtil showHUDWithMessage:@"请输入验证码" autoHide:YES];
        return;
    }
    
    [JJSUtil showHUDWithWaitingMessage:@"正在注册..."];
    [[KinGuartApi sharedKinGuard] registerAppAccountMobile:phone withPassword:pwd2 withSmscode:code success:^(NSDictionary *data) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:@"注册成功" autoHide:YES];
        
        //登陆
        [self performSelector:@selector(login:) withObject:nil afterDelay:1];
    } fail:^(NSString *error) {
        [JJSUtil hideHUD];
        
        [JJSUtil showHUDWithMessage:error autoHide:YES];
    }];
}

- (void)login:(id)sender
{
    NSString *phone = self.usernameField.text;
    NSString *pwd = self.pwdField2.text;
    
    [[KinGuartApi sharedKinGuard] loginWithMobile:phone withPassword:pwd success:^(NSDictionary *data) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:@"登陆成功" autoHide:YES];
        
        //跳转到主界面
        
    } fail:^(NSString *error) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:error autoHide:YES];
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

@end
