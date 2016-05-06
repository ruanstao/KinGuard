//
//  ForgetViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/4.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "ForgetViewController.h"
#import "JKCountDownButton.h"

@interface ForgetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labUsername;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField1;
@property (weak, nonatomic) IBOutlet UITextField *pwdField2;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"忘记密码";
    [self.labUsername setText:self.phone];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"topbtn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self. navigationItem.leftBarButtonItem = leftItem;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)resetAction:(id)sender
{
    NSString *pwd1 = self.pwdField1.text;
    NSString *pwd2 = self.pwdField2.text;
    NSString *code = self.codeField.text;
    
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
    [JJSUtil showHUDWithWaitingMessage:@"正在重置密码..."];
    [[KinGuartApi sharedKinGuard] setNewPasswordMobile:self.phone withPassword:pwd2 withSmscode:code success:^(NSDictionary *data) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:@"重置成功" autoHide:YES];
        
        //返回登陆页面
        
    } fail:^(NSString *error) {
        [JJSUtil hideHUD];
        [JJSUtil showHUDWithMessage:error autoHide:YES];
    }];
}

- (IBAction)getCode:(JKCountDownButton *)sender
{
    [JJSUtil showHUDWithWaitingMessage:@"正在发送验证码..."];
    [[KinGuartApi sharedKinGuard] catchSmsCodeWithMobile:self.phone withSmstype:@"1" success:^(NSDictionary *data) {
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
