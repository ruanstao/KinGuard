//
//  LocusViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/4.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "LocusViewController.h"

@interface LocusViewController ()<MAMapViewDelegate>

@property (strong, nonatomic) IBOutlet MAMapView *mapView;

@end

@implementation LocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self requestData];
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
- (IBAction)leftButtonAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:Show_LeftMenu object:nil];
}


- (void)initUI
{
    self.mapView.delegate = self;
}

- (void)requestData
{
    [[KinDeviceApi sharedKinDevice] deviceListSuccess:^(NSDictionary *data) {
        NSLog(@"%@",data);
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - <MAMapViewDelegate>

@end
