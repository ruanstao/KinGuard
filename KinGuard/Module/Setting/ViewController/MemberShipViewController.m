//
//  MemberShipViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/25.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "MemberShipViewController.h"

@interface MemberShipViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labMemerShip;
@property (weak, nonatomic) IBOutlet UIButton *motherButton;
@property (weak, nonatomic) IBOutlet UIButton *fatherButton;
@property (weak, nonatomic) IBOutlet UIButton *grandPaButton;
@property (weak, nonatomic) IBOutlet UIButton *grandFatherButton;
@property (weak, nonatomic) IBOutlet UIButton *grandMaButton;
@property (weak, nonatomic) IBOutlet UIButton *grandMotherButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@end

@implementation MemberShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"关系设置";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)motherAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.labMemerShip setText:@""];
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.bottomButton setTitle:@"其他关系" forState:UIControlStateNormal];
    }else{
        sender.selected = YES;
        [self.labMemerShip setText:@"妈妈"];
        sender.layer.borderColor = [UIColor redColor].CGColor;
        [self.bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    
    self.fatherButton.selected = NO;
    self.fatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandPaButton.selected = NO;
    self.grandPaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandFatherButton.selected = NO;
    self.grandFatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMaButton.selected = NO;
    self.grandMaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMotherButton.selected = NO;
    self.grandMotherButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)fatherAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.labMemerShip setText:@""];
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.bottomButton setTitle:@"其他关系" forState:UIControlStateNormal];
    }else{
        sender.selected = YES;
        [self.labMemerShip setText:@"爸爸"];
        sender.layer.borderColor = [UIColor blueColor].CGColor;
        [self.bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    
    self.motherButton.selected = NO;
    self.motherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandPaButton.selected = NO;
    self.grandPaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandFatherButton.selected = NO;
    self.grandFatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMaButton.selected = NO;
    self.grandMaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMotherButton.selected = NO;
    self.grandMotherButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)grandPaAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.labMemerShip setText:@""];
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.bottomButton setTitle:@"其他关系" forState:UIControlStateNormal];
    }else{
        sender.selected = YES;
        [self.labMemerShip setText:@"姥爷"];
        sender.layer.borderColor = [UIColor yellowColor].CGColor;
        [self.bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    self.fatherButton.selected = NO;
    self.fatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.motherButton.selected = NO;
    self.motherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandFatherButton.selected = NO;
    self.grandFatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMaButton.selected = NO;
    self.grandMaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMotherButton.selected = NO;
    self.grandMotherButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)grandFatherAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.labMemerShip setText:@""];
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.bottomButton setTitle:@"其他关系" forState:UIControlStateNormal];
    }else{
        sender.selected = YES;
        [self.labMemerShip setText:@"爷爷"];
        sender.layer.borderColor = [UIColor orangeColor].CGColor;
        [self.bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    self.fatherButton.selected = NO;
    self.fatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandPaButton.selected = NO;
    self.grandPaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.motherButton.selected = NO;
    self.motherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMaButton.selected = NO;
    self.grandMaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMotherButton.selected = NO;
    self.grandMotherButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)grandMaAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.labMemerShip setText:@""];
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.bottomButton setTitle:@"其他关系" forState:UIControlStateNormal];
    }else{
        sender.selected = YES;
        [self.labMemerShip setText:@"姥姥"];
        sender.layer.borderColor = [UIColor purpleColor].CGColor;
        [self.bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    
    self.fatherButton.selected = NO;
    self.fatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandPaButton.selected = NO;
    self.grandPaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.motherButton.selected = NO;
    self.motherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandFatherButton.selected = NO;
    self.grandFatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMotherButton.selected = NO;
    self.grandMotherButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)grandMotherAction:(UIButton *)sender {
    if (sender.selected) {
        sender.selected = NO;
        [self.labMemerShip setText:@""];
        sender.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.bottomButton setTitle:@"其他关系" forState:UIControlStateNormal];
    }else{
        sender.selected = YES;
        [self.labMemerShip setText:@"奶奶"];
        sender.layer.borderColor = [UIColor cyanColor].CGColor;
        [self.bottomButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    
    
    self.fatherButton.selected = NO;
    self.fatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandPaButton.selected = NO;
    self.grandPaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.motherButton.selected = NO;
    self.motherButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandMaButton.selected = NO;
    self.grandMaButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.grandFatherButton.selected = NO;
    self.grandFatherButton.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)bottomAction:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"确定"]) {
        [JJSUtil showHUDWithWaitingMessage:nil];
        [[KinDeviceApi sharedKinDevice] setRelationshipWithPid:self.info.asset_id withRelationship:self.labMemerShip.text success:^(NSDictionary *data) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:@"关系设定成功" autoHide:YES];
            
            if (self.type == FromType_Setting) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } fail:^(NSString *error) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:error autoHide:YES];
        }];
    }else{
        UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"其他关系" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
        dialog.tag = 2;
        [dialog show];
    }
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
