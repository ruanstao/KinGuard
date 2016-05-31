//
//  FollowViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/10.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "FollowViewController.h"
#import "JKCountDownButton.h"
#import "UserModel.h"

@interface FollowViewController ()
@property (weak, nonatomic) IBOutlet UITextField *codeField;

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关注设备";
}

- (IBAction)getCodeAction:(JKCountDownButton *)sender {
    
    [JJSUtil showHUDWithWaitingMessage:@"正在发送验证码..."];
    if (self.type == BindType_QRCode) {
        [[KinDeviceApi sharedKinDevice] bindFollowByQRCode:self.qrcode withSmscode:@"" success:^(NSDictionary *data) {
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
        }fail:^(NSString *error) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:error autoHide:YES];
        }];
    }else{
        [[KinDeviceApi sharedKinDevice] bindFollowByPid:self.pid withKey:self.akey withSmscode:@"" success:^(NSDictionary *data) {
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
        }fail:^(NSString *error) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:error autoHide:YES];
        }];
    }
}

- (IBAction)nextAction:(UIButton *)sender {
    NSString *code = self.codeField.text;
    if ([JJSUtil isBlankString:code]) {
        [JJSUtil showHUDWithMessage:@"请输入验证码" autoHide:YES];
        return;
    }
    if (self.type == BindType_QRCode) {//从扫描二维码进入关注页面
        [JJSUtil showHUDWithWaitingMessage:@"绑定中..."];
        [[KinDeviceApi sharedKinDevice] bindFollowByQRCode:self.qrcode withSmscode:code success:^(NSDictionary *data) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:@"绑定成功" autoHide:YES];
            
            [JJSUtil getDataWithKey:KinGuard_UserInfo Completion:^(BOOL finish, id obj) {
                if (obj) {
                    NSData *userData = obj;
                    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
                    model.isLogined = YES;
                    
                    NSData *storeData = [NSKeyedArchiver archivedDataWithRootObject:model];
                    [JJSUtil storageDataWithObject:storeData Key:KinGuard_UserInfo Completion:^(BOOL finish, id obj) {
                        //跳转到主界面
                        ViewController *viewController = [[ViewController alloc] init];
                        self.view.window.rootViewController = viewController;
                    }];
                }
            }];
            
        } fail:^(NSString *error) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:error autoHide:YES];
        }];
    }else{//从设备号绑定进入关注页面
        [JJSUtil showHUDWithWaitingMessage:@"绑定中..."];
        [[KinDeviceApi sharedKinDevice] bindFollowByPid:self.pid withKey:self.akey withSmscode:code success:^(NSDictionary *data) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:@"绑定成功" autoHide:YES];
            
            [JJSUtil getDataWithKey:KinGuard_UserInfo Completion:^(BOOL finish, id obj) {
                if (obj) {
                    NSData *userData = obj;
                    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
                    model.isLogined = YES;
                    
                    NSData *storeData = [NSKeyedArchiver archivedDataWithRootObject:model];
                    [JJSUtil storageDataWithObject:storeData Key:KinGuard_UserInfo Completion:^(BOOL finish, id obj) {
                        //跳转到主界面
                        ViewController *viewController = [[ViewController alloc] init];
                        self.view.window.rootViewController = viewController;
                    }];
                }
            }];
        } fail:^(NSString *error) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:error autoHide:YES];
        }];
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
