//
//  PosHisInfoViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/21.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "PosHisInfoViewController.h"

@interface PosHisInfoViewController()<MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@end

@implementation PosHisInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self requestData:[NSDate date]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.mapView.delegate = self;
    self.mapView.showsScale = NO;
    self.mapView.showsCompass = NO;
    self.backBtn.frame = CGRectMake(0, 0, 40, 23);
    [self.backBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [self.backBtn setImage:nil forState:UIControlStateNormal];
    [self.backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.backBtn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)requestData:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
          formatter.dateFormat =  @"yyyy-MM-dd HH:mm:ss";

    NSMutableString *beginTimeStr =[NSMutableString stringWithString: [formatter stringFromDate:[JJSUtil beginTime:date]]];
    NSMutableString *endTimeStr = [NSMutableString stringWithString:[formatter stringFromDate:[JJSUtil endTime:date]]];
    [beginTimeStr insertString:@"T" atIndex:[beginTimeStr rangeOfString:@" "].location];
    [endTimeStr insertString:@"T" atIndex:[endTimeStr rangeOfString:@" "].location];
//    2016-03-29T 08:00:00
    [[KinLocationApi sharedKinLocation] readPosHisInfo:self.pid?:@"" withBegdt:beginTimeStr withEnddt:endTimeStr success:^(NSDictionary *data) {
        NSLog(@"%@",data);

    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}



@end
