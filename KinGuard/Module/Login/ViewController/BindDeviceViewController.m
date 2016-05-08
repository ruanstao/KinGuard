//
//  BindDeviceViewController.m
//  邦邦熊
//
//  Created by 莫菲 on 16/2/24.
//  Copyright © 2016年 linktop. All rights reserved.
//

#import "BindDeviceViewController.h"
//#import "XDScaningViewController.h"
#import "UIImage+IAnime.h"

@interface BindDeviceViewController ()//<ZBarReaderDelegate>
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

@end

@implementation BindDeviceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"添加卡片";
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
    
    UIBarButtonItem* leftItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"topbtn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self. navigationItem.leftBarButtonItem=leftItem;
    // Do any additional setup after loading the view.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
//    XDScaningViewController* scanVC=[[UIStoryboard storyboardWithName:@"LoginRegister" bundle:nil] instantiateViewControllerWithIdentifier:@"XDScaningVC"];
//    [scanVC setBackValue:^(NSString * qr_code) {
//        [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"绑定中" duration:10 allowEdit:nil beginBlock:nil completeBlock:nil];
//       NSDictionary* result= [serverAPI BindDevice:qr_code];
//        if ([result[@"state"] intValue]>4) {
//            [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"未知错误，请重试" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//        }
//        switch ([result[@"state"] intValue]) {
//            case 0:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"绑定成功" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//            case 1:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"绑定中，请等待设备确认" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//            case 2:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"工厂未登记" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//            case 3:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"已被其他人绑定" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//                
//            default:
//                break;
//        }
//    }];
    //设置代理
//    reader.readerDelegate = self;
//    //基本适配
//    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    
//    //二维码/条形码识别设置
//    ZBarImageScanner *scanner = reader.scanner;
//    
//    [scanner setSymbology: ZBAR_I25
//                   config: ZBAR_CFG_ENABLE
//                       to: 0];
    //弹出系统照相机，全屏拍摄
//    [self presentModalViewController: scanVC
//                            animated: YES];
}
/**
 *  ID激活并绑定
 */
- (IBAction)bindDevice:(id)sender {
//    NSDictionary* result= [serverAPI BindDeviceID:_deviceIdField.text AKey:_safeCodeField.text];
//    if ([result[@"state"] intValue]>4) {
//        [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"未知错误，请重试" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//    }
//    else{
//        switch ([result[@"state"] intValue]) {
//            case 0:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"绑定成功" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//            case 1:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"绑定中，请等待设备确认" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//            case 2:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"工厂未登记" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//            case 3:
//                [CoreSVP showSVPWithType:CoreSVPTypeCenterMsg Msg:@"已被其他人绑定" duration:1.5 allowEdit:NO beginBlock:nil completeBlock:nil];
//                break;
//                
//            default:
//                break;
//
//    }
//        }
}


@end
