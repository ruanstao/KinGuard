//
//  AccountSafeViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/15.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "AccountSafeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "VPImageCropperViewController.h"
#import "AccountInfo.h"
#import "ForgetViewController.h"

#define ORIGINAL_MAX_WIDTH 640.0f

@interface AccountSafeViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *labNickName;
@property (weak, nonatomic) IBOutlet UILabel *labEmail;
@property (weak, nonatomic) IBOutlet UILabel *labPhone;
@property (nonatomic, strong) VPImageCropperViewController *imgEditorController;

@property (nonatomic, strong) AccountInfo *accountInfo;
@property (nonatomic, strong) NSData *headData;//待上传头像数据
@property (nonatomic, copy) NSString *nickName;//更改昵称待上传
@property (nonatomic, copy) NSString *email;//更改邮箱待上传

@end

@implementation AccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账号与安全";
    
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
    
    self.headView.clipsToBounds = YES;
    self.headView.layer.cornerRadius = mScreenWidth *(300/736);
    
    [self getUserInfo];
    [self downHeadImageInfo];
}

- (void)back
{
    if (![JJSUtil isBlankString:self.nickName] || ![JJSUtil isBlankString:self.email] || self.headData != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的账号信息已改变，是否保存？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        [alert setTag:40];
        [alert show];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//更新用户信息
- (void)updateUserInfoToServer
{
    if (![JJSUtil isBlankString:self.nickName] || ![JJSUtil isBlankString:self.email]) {
        NSString *alias = self.accountInfo.alias;
        if (![JJSUtil isBlankString:self.nickName]) {
            alias = self.nickName;
        }
        NSString *addr = self.accountInfo.alias;
        if (![JJSUtil isBlankString:self.email]) {
            addr = self.email;
        }
        [JJSUtil showHUDWithWaitingMessage:@"账号信息更新中..."];
        [[KinGuartApi sharedKinGuard] updateUserInfoWithMobile:self.accountInfo.acc withAddr:addr withIddno:@"" withAccName:self.accountInfo.acc_name withAlias:alias withSex:@"" withBirthdate:@"" success:^(NSDictionary *data) {
            [JJSUtil hideHUD];
            NSLog(@"update:%@",data);
            //若有头像需要更新则上传头像
            if (self.headData != nil) {
                //待完成
                NSString *pid = [[NSUserDefaults standardUserDefaults] objectForKey:KinGuard_Device];
                if (![JJSUtil isBlankString:pid]) {
                    [[KinGuartApi sharedKinGuard] uploadHeadPortraitByPid:pid withImageData:self.headData uploadProgress:^(NSProgress *progress) {
                        
                    } finished:^(NSDictionary *data) {
                        [JJSUtil showHUDWithMessage:@"更新成功" autoHide:YES];
                        [self.navigationController popViewControllerAnimated:YES];
                    } failed:^(NSString *error) {
                        [JJSUtil showHUDWithMessage:error autoHide:YES];
                    }];
                }else{
                    [JJSUtil showHUDWithMessage:@"未绑定设备号无法更新信息" autoHide:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [JJSUtil showHUDWithMessage:@"更新成功" autoHide:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            
        } fail:^(NSString *error) {
            [JJSUtil hideHUD];
            [JJSUtil showHUDWithMessage:error autoHide:YES];
        }];
    }else{
        //待完成
        NSString *pid = [[NSUserDefaults standardUserDefaults] objectForKey:KinGuard_Device];
        if (![JJSUtil isBlankString:pid]) {
            [[KinGuartApi sharedKinGuard] uploadHeadPortraitByPid:pid withImageData:self.headData uploadProgress:^(NSProgress *progress) {
                
            } finished:^(NSDictionary *data) {
                [JJSUtil showHUDWithMessage:@"更新成功" autoHide:YES];
                [self.navigationController popViewControllerAnimated:YES];
            } failed:^(NSString *error) {
                [JJSUtil showHUDWithMessage:error autoHide:YES];
            }];
        }else{
            [JJSUtil showHUDWithMessage:@"未绑定设备号无法更新信息" autoHide:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//下载用户头像（待完成）
- (void)downHeadImageInfo
{
    NSString *pid = [[NSUserDefaults standardUserDefaults] objectForKey:KinGuard_Device];
    if (![JJSUtil isBlankString:pid]) {
        [[KinGuartApi sharedKinGuard] downloadHeadPortraitByPid:@"" andProgress:^(NSProgress *progress) {
            
        } finished:^(NSDictionary *data) {
            NSLog(@"%@",data);
        } failed:^(NSString *error) {
            
        }];
    }
    
}

//获取用户数据
- (void)getUserInfo
{
    [[KinGuartApi sharedKinGuard] getUserInfoSuccess:^(NSDictionary *data) {
        NSLog(@"userInfo:%@",data);
        self.accountInfo = [AccountInfo mj_objectWithKeyValues:data];
        [self updateUserInfo];
    } fail:^(NSString *error) {
        NSLog(@"error:%@",error);
        [JJSUtil showHUDWithMessage:@"用户信息获取失败" autoHide:YES];
    }];
}

- (IBAction)headAction:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"头像设置" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    
    [sheet showInView:self.view];
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

- (void)updateUserInfo
{
    [self.labNickName setText:self.accountInfo.alias];
    [self.labEmail setText:self.accountInfo.addr];
    [self.labPhone setText:self.accountInfo.acc];
}

//昵称
- (IBAction)nickAction:(id)sender
{
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"请输入昵称" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
    dialog.tag = 1;
    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    [dialog show];
}
//邮箱
- (IBAction)emailAction:(id)sender
{
    UIAlertView *dialog = [[UIAlertView alloc] initWithTitle:@"请输入邮箱" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消",nil];
    [dialog setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[dialog textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeDefault];
    dialog.tag = 2;
    [dialog show];
}
//修改密码
- (IBAction)fixPasswordAction:(id)sender
{
    ForgetViewController* forgetVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ForgetViewController"];
    forgetVC.phone = self.accountInfo.acc;
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *text = [alertView textFieldAtIndex:0].text;
    if (alertView.tag == 1)
    {
        if (!buttonIndex) {
            if (![JJSUtil isBlankString:text]) {
                [self.labNickName setText:text];
                self.nickName = text;
            }
        }
    }else if (alertView.tag == 2)
    {
        if (!buttonIndex) {
            if (![JJSUtil isBlankString:text]) {
                [self.labEmail setText:text];
                self.email = text;
            }
        }
    }else if (alertView.tag == 40)
    {
        if (buttonIndex) {
            //保存用户信息
            [self updateUserInfoToServer];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self.navigationController presentViewController:controller
                                                    animated:YES
                                                  completion:^(void){
                                                      NSLog(@"Picker View Controller is presented");
                                                  }];
        }
    }else if (buttonIndex == 1) {
        //从相册选择
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        self.imgEditorController = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        self.imgEditorController.delegate = self;
        [self performSelector:@selector(presentCameraView) withObject:nil afterDelay:0.6f];
        
    }];
}

- (void)presentCameraView
{
    [self presentViewController:self.imgEditorController animated:YES completion:^{
        // TO DO
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    self.headData = UIImagePNGRepresentation(editedImage);
    
    [self.headView setImage:editedImage];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
//        [JJSUtil showHUDWithWaitingMessage:@"正在上传头像"];
//        [[KinGuartApi sharedKinGuard] uploadHeadPortraitByPid:@"" withImageData:data uploadProgress:^(NSProgress *progress) {
//            NSLog(@"%@",progress);
//        } finished:^(NSDictionary *data) {
//            [JJSUtil hideHUD];
//            [JJSUtil showHUDWithMessage:@"上传成功" autoHide:YES];
//        } failed:^(NSString *error) {
//            [JJSUtil hideHUD];
//            [JJSUtil showHUDWithMessage:@"上传失败" autoHide:YES];
//        }];
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage
{
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
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
