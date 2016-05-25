//
//  SafeZoneViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/22.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "SafeZoneViewController.h"
#import "SetSafeZoneViewController.h"

@interface SafeZoneViewController ()<MAMapViewDelegate>
@property(nonatomic, strong) MAMapView *mapView;
@end

@implementation SafeZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"安全区域";
    [self initilizeBaseView];
    
}

- (void)initilizeBaseView
{
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    self.mapView.delegate = self;
    self.mapView.showsScale = YES;
    self.mapView.zoomLevel = 15.6;
    [self.view addSubview:self.mapView];
    
    MAPointAnnotation *pointAnno = [[MAPointAnnotation alloc] init];
    
    pointAnno.coordinate = CLLocationCoordinate2DMake(self.safeModel.latitude.doubleValue, self.safeModel.longitude.doubleValue);
    
    [self.mapView addAnnotation:pointAnno];
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(self.safeModel.latitude.doubleValue, self.safeModel.longitude.doubleValue) animated:YES];
    
    //构造圆
    MACircle *circle = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(self.safeModel.latitude.doubleValue, self.safeModel.longitude.doubleValue) radius:self.safeModel.radius.doubleValue];
    
    //在地图上添加圆
    [self.mapView addOverlay: circle];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(5, mScreenHeight - 75, mScreenWidth - 10, 70)];
    [bottomView setClipsToBounds:YES];
    bottomView.layer.cornerRadius = 5;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UILabel *labAddr = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, mScreenWidth - 30 - 50, 30)];
    [labAddr setNumberOfLines:0];
    [labAddr setFont:[UIFont systemFontOfSize:16]];
    [labAddr setText:self.safeModel.addr];
    [bottomView addSubview:labAddr];
    
    UILabel *labRadius = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, mScreenWidth - 30 - 50, 15)];
    [labRadius setText:[[@"范围：" stringByAppendingString:self.safeModel.radius] stringByAppendingString:@"米"]];
    [labRadius setTextColor:[UIColor redColor]];
    [labRadius setFont:[UIFont systemFontOfSize:14]];
    [bottomView addSubview:labRadius];
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightItem setFrame:CGRectMake(mScreenWidth - 30 - 50, 20, 50, 30)];
    [rightItem setTitle:@"查看" forState:UIControlStateNormal];
    [rightItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightItem.layer setCornerRadius:5];
    [rightItem setBackgroundColor:[UIColor colorWithRed:0 green:124/255.0 blue:195/255.0 alpha:1]];
    [rightItem addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rightItem];
}

- (void)setAction:(id)sender
{
    SetSafeZoneViewController *setController = [[SetSafeZoneViewController alloc] init];
    setController.safeModel = self.safeModel;
    [self.navigationController pushViewController:setController animated:YES];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"local_1"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -10);
        return annotationView;
    }
    return nil;
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleView *circleView = [[MACircleView alloc] initWithCircle:overlay];
        
        circleView.lineWidth = 5.f;
        circleView.strokeColor = [UIColor whiteColor];
        circleView.fillColor = [UIColor colorWithRed:0.77 green:0.88 blue:0.94 alpha:0.8];
//        circleView.lineDash = YES;//YES表示虚线绘制，NO表示实线绘制
        
        return circleView;
    }
    return nil;
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
