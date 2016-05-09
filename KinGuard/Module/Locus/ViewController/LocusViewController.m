//
//  LocusViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/4.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "LocusViewController.h"
#import "DeviceInfo.h"
#import "RtOutputView.h"
#import "LocationInfo.h"

@interface LocusViewController ()<MAMapViewDelegate>

@property (strong, nonatomic) IBOutlet MAMapView *mapView;

@property (nonatomic,strong) NSArray *pids;

@property (nonatomic,strong) NSArray *info;

@property (nonatomic,assign) NSInteger showIndex;

@property (strong, nonatomic) IBOutlet UIButton *headerTitle;

@property (nonatomic,strong) LocationInfo *currentLocation;

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

- (void)refreshUI
{
    if (self.info.count > 0) {
        DeviceInfo *info = self.info[self.showIndex];
        [self.headerTitle setTitle:info.asset_name forState:UIControlStateNormal];
        //开始定位
//        [[KinLocationApi sharedKinLocation] startNormalLocation:info.asset_id success:^(NSDictionary *data) {
//            NSLog(@"%@",data);
//        } fail:^(NSString *error) {
//            NSLog(@"%@",error);
//        }];
        
        [[KinLocationApi sharedKinLocation]readLocationInfo:info.asset_id success:^(NSDictionary *data) {
            
            NSLog(@"%@",data);
            self.currentLocation = [LocationInfo mj_objectWithKeyValues:data];
            [self beginLocation];
        } fail:^(NSString *error) {
            
            NSLog(@"%@",error);
        }];
    }
    
}

- (void)requestData
{
    [[KinDeviceApi sharedKinDevice] deviceListSuccess:^(NSDictionary *data) {
        NSLog(@"%@",data);
        self.pids = @[[data objectForKey:@"pids"]?:@[]];
        if (self.pids.count> 0) {
            NSMutableArray *infoArr = [NSMutableArray array];
            for (NSString *pid in self.pids) {
                [self requestDeviceInfo:pid finish:^(DeviceInfo *info) {
                    [infoArr addObject:info];
                    if (infoArr.count == self.pids.count) {
                        self.info = infoArr;
                        [self refreshUI];
                    }
                }];
            }
        }
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestDeviceInfo:(NSString *)pid finish:(void (^)(DeviceInfo *info))block
{
    [[KinDeviceApi sharedKinDevice] deviceInfoPid:pid success:^(NSDictionary *data) {
         NSLog(@"%@",data);
        if (block) {
            block([DeviceInfo mj_objectWithKeyValues:data]);
        }
    } fail:^(NSString *error) {
         NSLog(@"%@",error);
    }];
    
}


#pragma mark - headTItle
- (IBAction)HeadButtonAction:(UIButton *)sender
{
    NSMutableArray *dataArr = [NSMutableArray array];
    for (DeviceInfo *info in self.info) {
        RtCellModel *model = [[RtCellModel alloc] initWithTitle:info.asset_name imageName:@""];
        [dataArr addObject:model];
    }
    CGFloat x = sender.center.x;
    CGFloat y = CGRectGetMaxY(sender.frame) + 20;
    RtOutputView * outputView = [[RtOutputView alloc] initWithDataArray:dataArr origin:CGPointMake(x, y) width:125 height:44 direction:kRtOutputViewDirection_Middle];

    outputView.didSelectedAtIndexPath = ^(NSIndexPath *index){
        self.showIndex = index.row;
        [self refreshUI];
    };
    
    outputView.dismissWithOperation = ^(){
    //设置成nil，以防内存泄露
    };
    [outputView pop];


}

#pragma mark - <MAMapViewDelegate>

- (void)beginLocation
{
    self.mapView.showsUserLocation = YES;
    self.mapView.region = MACoordinateRegionMake(CLLocationCoordinate2DMake(self.currentLocation.latitude, self.currentLocation.longitude), MACoordinateSpanMake(0.05, 0.05));
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.currentLocation.latitude, self.currentLocation.longitude) animated:YES];
}
@end
