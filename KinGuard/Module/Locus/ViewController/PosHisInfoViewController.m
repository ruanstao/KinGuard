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
#import "WHUCalendarView.h"

@interface PosHisInfoViewController()<MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@property (nonatomic,strong) NSArray *locationArray;

//@property (nonatomic, strong) Record *currentRecord;

@property (nonatomic, strong) MAPointAnnotation *personLocation;

@property (nonatomic, assign) double averageSpeed;

@property (nonatomic, assign) NSInteger currentLocationIndex;

@property (strong, nonatomic) IBOutlet WHUCalendarView *calView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *calViewHeight;

@end

@implementation PosHisInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavi];
    [self initUI];
    [self requestData:[NSDate date]];
    [self initCalendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavi
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"日历" style:UIBarButtonItemStylePlain target:self action:@selector(show)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
    NSMutableString *currentData =[NSMutableString stringWithString: [formatter stringFromDate:[JJSUtil beginTime:[NSDate date]]]];
//    [beginTimeStr insertString:@"T" atIndex:[beginTimeStr rangeOfString:@" "].location];
//    [endTimeStr insertString:@"T" atIndex:[endTimeStr rangeOfString:@" "].location];
    //    2016-03-29T 08:00:00
    [JJSUtil showHUDWithWaitingMessage:@""];
    [[KinLocationApi sharedKinLocation] readPosHisInfo:self.pid?:@"" withBegdt:beginTimeStr withEnddt:endTimeStr success:^(NSDictionary *data) {
        [JJSUtil hideHUD];
        NSLog(@"%@",data);
        self.locationArray = [LocationInfo mj_objectArrayWithKeyValuesArray:(NSArray *)data];
        if ([currentData isEqualToString:beginTimeStr]) {
            [self refreashUI:NO];
        }else{
            
            [self refreashUI:YES];
            
        }
    } fail:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}

- (void)refreashUI:(BOOL)animation
{
    if (self.locationArray.count < 1) {
        return;
    }
    [self.mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.mapView removeAnnotation:obj];
    }];
    CLLocationCoordinate2D lineCoords[self.locationArray.count];
    MAMapPoint mapPoints[self.locationArray.count];
    MAMapPoint range_X; //X轴范围，x最小，y最大
    MAMapPoint range_Y; //Y轴范围，x最小，y最大
    for (int i = 0; i < self.locationArray.count;i++ ) {
        LocationInfo *info = self.locationArray[i];
        MAPointAnnotation *pointAnno = [[MAPointAnnotation alloc] init];

        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(info.latitude, info.longitude);
        pointAnno.coordinate = coord;
        lineCoords[i] = coord;
        MAMapPoint pp = MAMapPointForCoordinate(coord);
        mapPoints[i] = pp;
        //算这些点的范围
        if (i == 0) {
            range_X = MAMapPointMake(mapPoints[0].x, mapPoints[0].x);
            range_Y = MAMapPointMake(mapPoints[0].y, mapPoints[0].y);
        }else {
            if (mapPoints[i].x < range_X.x) {
                range_X.x = mapPoints[i].x;
            }
            if (mapPoints[i].x > range_X.y) {
                range_X.y = mapPoints[i].x;
            }
            if (mapPoints[i].y < range_Y.x) {
                range_Y.x = mapPoints[i].y;
            }
            if (mapPoints[i].y > range_Y.y) {
                range_Y.y = mapPoints[i].y;
            }
        }
        [self.mapView addAnnotation:pointAnno];
        
    }
    //draw Line
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:lineCoords count:self.locationArray.count];
    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];

//    CLLocationDistance maxDistance = MAMetersBetweenMapPoints(MAMapPointMake(range_X.x,range_Y.x),MAMapPointMake(range_X.y,range_Y.y));
    CLLocationDistance distance_X = MAMetersBetweenMapPoints(MAMapPointMake(range_X.x,range_Y.x),MAMapPointMake(range_X.y,range_Y.x));
    CLLocationDistance distance_Y = MAMetersBetweenMapPoints(MAMapPointMake(range_X.x,range_Y.x),MAMapPointMake(range_X.x,range_Y.y));
    CLLocationCoordinate2D middle = MACoordinateForMapPoint(MAMapPointMake((range_X.x + range_X.y) / 2, (range_Y.x + range_Y.y) / 2));
    self.mapView.region = MACoordinateRegionMakeWithDistance( middle, distance_X * 3 / 2  , distance_Y * 3 / 2);
    [self.mapView setCenterCoordinate:middle animated:YES];
    
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    if (animation) {
        [self actionPlayAndStop];
    }


}
#pragma mark - <MAMapViewDelegate>

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if([annotation isEqual:self.personLocation]) {

        static NSString *annotationIdentifier = @"personLcoationIdentifier";

        MAAnnotationView *poiAnnotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        }

        poiAnnotationView.image = [UIImage imageNamed:@"icon_my_loacation"];
        poiAnnotationView.canShowCallout = NO;

        return poiAnnotationView;
    }

    NSString *reuseIndetifier = @"PosHisInfoAnnotationView";
    MAAnnotationView *annotaionView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
    if (annotaionView == nil) {
        annotaionView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
    }
    annotaionView.canShowCallout = YES;
    annotaionView.image = [UIImage imageNamed:@"point_gps"];
    return annotaionView;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth = 3.f;
        polylineRenderer.strokeColor = HexRGB(0xBBF0FF);
//        [UIColor colorWithRed:0.5 green:1 blue:0.8 alpha:0.8];
        polylineRenderer.lineJoin = kCGLineJoinRound;//连接类型
        polylineRenderer.lineCap = kCGLineCapRound;//端点类型
        
        return polylineRenderer;
    }
    return nil;
}

#pragma mark - Action

- (void)actionPlayAndStop
{
    if (self.personLocation !=nil) {
        [self.mapView removeAnnotation:self.personLocation];
        self.personLocation = nil;
    }

    if (self.personLocation == nil)
    {
        LocationInfo *info = self.locationArray[0];
        self.personLocation = [[MAPointAnnotation alloc] init];
//            self.personLocation.title = @"AMap";
        self.personLocation.coordinate = CLLocationCoordinate2DMake(info.latitude, info.longitude);

        [self.mapView addAnnotation:self.personLocation];
    }
    self.averageSpeed = 1;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self animateToNextCoordinate];
        });
    });

}

- (void)animateToNextCoordinate
{
    if (self.personLocation == nil)
    {
        return;
    }
    if (self.currentLocationIndex == [self.locationArray count] )
    {
        self.currentLocationIndex = 0;
//        [self actionPlayAndStop];
        return;
    }
    LocationInfo *info = self.locationArray[self.currentLocationIndex];
    CLLocationCoordinate2D nextCoord = CLLocationCoordinate2DMake(info.latitude, info.longitude);
//    CLLocationCoordinate2D preCoord = self.currentLocationIndex == 0 ? nextCoord : self.myLocation.coordinate;
    MAMapPoint nextPoint = MAMapPointForCoordinate(nextCoord);
    MAMapPoint currentPoint = MAMapPointForCoordinate(self.personLocation.coordinate);
    CLLocationDistance distance = MAMetersBetweenMapPoints(currentPoint,nextPoint);
    if (distance < 1) {
        self.currentLocationIndex++;
        [self animateToNextCoordinate];
        return;
    }
    CLLocationDistance distance_X = MAMetersBetweenMapPoints(MAMapPointMake(currentPoint.x,currentPoint.y),MAMapPointMake(nextPoint.x,currentPoint.y));
    CLLocationDistance distance_Y = MAMetersBetweenMapPoints(MAMapPointMake(currentPoint.x,currentPoint.y),MAMapPointMake(currentPoint.x,nextPoint.y));
    CLLocationCoordinate2D middle = MACoordinateForMapPoint(MAMapPointMake((currentPoint.x +nextPoint.x) / 2, (currentPoint.y + nextPoint.y) / 2));

    [self.mapView setRegion:MACoordinateRegionMakeWithDistance( middle, distance_X * 3 / 2  , distance_Y * 3 / 2) animated:YES];
    [self.mapView setCenterCoordinate:middle animated:YES];

//    NSTimeInterval duration = distance / (self.averageSpeed * 1000) ;
    [UIView animateWithDuration:2
                     animations:^{
                         self.personLocation.coordinate = nextCoord;}
                     completion:^(BOOL finished){
                         self.currentLocationIndex++;
                         if (finished)
                         {
                             [self animateToNextCoordinate];
                         }}];

}


#pragma mark - 日历

- (void)initCalendarView
{

    CGSize s=[ self.calView sizeThatFits:CGSizeMake(mScreenWidth, FLT_MAX)];
    self.calViewHeight.constant = s.height;
    self.calView.hidden = YES;
    typeof(self) weakSelf = self;
    _calView.onDateSelectBlk=^(NSDate* date){
        typeof(weakSelf) strongSelf = weakSelf;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [strongSelf requestData:date];
            [strongSelf dismiss];
        });
    };
    
}

-(void)show{

    self.calView.hidden = NO;
}


-(void)dismiss{

    self.calView.hidden = YES;
    
}

@end
