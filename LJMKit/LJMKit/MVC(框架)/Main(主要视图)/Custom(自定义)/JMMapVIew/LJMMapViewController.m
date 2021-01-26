//
//  LJMMapViewController.m
//  LJMKit
//
//  Created by ios on 2020/9/1.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "LJMMapViewController.h"
//#import <MAMapKit/MAMapKit.h>
#import <FBShimmeringView.h>

@interface LJMMapViewController ()
// <MAMapViewDelegate>

///// locManager
//@property (nonatomic, strong) CLLocationManager *manager;
///// mapView
//@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation LJMMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"地图";
    self.view.backgroundColor = kBackgroud_Color_Main;
    
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:shimmeringView];

    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = NSLocalizedString(@"Shimmer", nil);
    shimmeringView.contentView = loadingLabel;

    // Start shimmering.
    shimmeringView.shimmering = YES;

//    // 开启定位
//    self.manager = CLLocationManager.alloc.init;
//    [self.manager requestAlwaysAuthorization];
//    // 添加地图
//    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    self.mapView.delegate = self;
//    [self.view addSubview:self.mapView];
//    // 当前位置
//    self.mapView.showsUserLocation = YES;
//    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
//    // 指定位置
//    [self.mapView setRegion:MACoordinateRegionMake(CLLocationCoordinate2DMake(31.22899725239286, 121.51501883480833), MACoordinateSpanMake(0.005, 0.005)) animated:YES];
}

//#pragma mark - MAMapViewDelegate
//
//- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager {
//
//}

@end
