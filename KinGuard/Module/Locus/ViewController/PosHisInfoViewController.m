//
//  PosHisInfoViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/21.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "PosHisInfoViewController.h"
#import "LocationInfo.h"
#import <MAMapKit/MAMapKit.h>

@interface PosHisInfoViewController()<MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@property (nonatomic,strong) NSArray *locationArray;

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
        self.locationArray = [LocationInfo mj_objectArrayWithKeyValuesArray:(NSArray *)data];
        [self refreashUI];
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)refreashUI
{
    if (self.locationArray.count < 1) {
        return;
    }
    [self.mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.mapView removeAnnotation:obj];
    }];
    CLLocationCoordinate2D lineCoords[self.locationArray.count];
    
    for (int i = 0; i < self.locationArray.count;i++ ) {
        LocationInfo *info = self.locationArray[i];
        MAPointAnnotation *pointAnno = [[MAPointAnnotation alloc] init];
        //        pointAnno.title = self.currentLocation.addr;
        //        pointAnno.subtitle = [JJSUtil timeDateFormatter:[NSDate dateWithTimeIntervalSince1970:self.currentLocation.timestamp] type:10];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(info.latitude, info.longitude);
        pointAnno.coordinate = coord;
        lineCoords[i] = coord;
        [self.mapView addAnnotation:pointAnno];
        
    }
    //draw Line
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:lineCoords count:self.locationArray.count];
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    self.mapView.region = MACoordinateRegionMakeWithDistance( lineCoords[0], 100, 100);
    //    MAMetersBetweenMapPoints
    //    MACoordinateRegionMake(CLLocationCoordinate2DMake(self.currentLocation.latitude, self.currentLocation.longitude), MACoordinateSpanMake(0.1, 0.1));
    //    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.currentLocation.latitude, self.currentLocation.longitude) animated:YES];
}
#pragma mark - <MAMapViewDelegate>

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    NSString *reuseIndetifier = @"PosHisInfoAnnotationView";
    MAAnnotationView *annotaionView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
    if (annotaionView == nil) {
        annotaionView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
    }
    annotaionView.canShowCallout = YES;
    annotaionView.image = [UIImage imageNamed:@"street_on"];
    return annotaionView;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth = 4.f;
        polylineRenderer.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.6];
        polylineRenderer.lineJoin = kCGLineJoinRound;//连接类型
        polylineRenderer.lineCap = kCGLineCapRound;//端点类型
        
        return polylineRenderer;
    }
    return nil;
}
@end
