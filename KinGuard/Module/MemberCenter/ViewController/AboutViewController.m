//
//  AboutViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/17.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labVersion;
@property (weak, nonatomic) IBOutlet UILabel *labCopyright;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于星联守护";
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [self.labVersion setText:[@"v " stringByAppendingString:app_Version]];
    
    [self.labCopyright setText:@"Copyright © 2015-2016 Xiamen Kinzol. \n All Rights Reserved."];
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
