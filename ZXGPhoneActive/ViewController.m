//
//  ViewController.m
//  ZXGPhoneActive
//
//  Created by zxg on 2018/3/15.
//  Copyright © 2018年 zxg. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import <CoreLocation/CoreLocation.h>
#import "ZPAPhoneActiveTime.h"
#import "ZPANotificationManager.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, weak) UILabel *tipsLable;
@property (nonatomic, weak) UIImageView *tipsImageView;
@property (nonatomic, strong) CLLocationManager *locationManger;
@property (nonatomic, assign) int limit_Time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initSubViews];
    [self initLocationManger];
    [self initNSTimer];
    [self initPhoneActiveTime];
}

- (void)initPhoneActiveTime
{
    ZPANotificationManager *notificationManager = [ZPANotificationManager sharedNotificationManager];
    
    ZPAPhoneActiveTime *phoneActiveTime = [ZPAPhoneActiveTime sharedPhoneActiveTime];
    [phoneActiveTime recordPhoneActiveTimeWithLockedBlock:^(NSDictionary *infoDict) {
        //屏幕锁定
        NSLog(@"屏幕锁定");
        
        
    } AndScreenUnLockedBlock:^(NSDictionary *infoDict) {
        //屏幕解锁
        NSLog(@"屏幕解锁");
        [notificationManager registerNotification:1];
        
    }];
}

- (void)initSubViews
{
    UILabel *tipsLable = [[UILabel alloc] init];
    tipsLable.textAlignment = NSTextAlignmentCenter;
    tipsLable.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:tipsLable];
    self.tipsLable = tipsLable;

    [self.tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideTop).offset(200);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *tipsImageView = [[UIImageView alloc] init];
    tipsImageView.contentMode = UIViewContentModeScaleAspectFit;
    tipsImageView.image = [UIImage imageNamed:@"bigBrother"];
    [self.view addSubview:tipsImageView];
    self.tipsImageView = tipsImageView;
    
    [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}

- (void)initLocationManger
{
    self.locationManger = [[CLLocationManager alloc] init];
    self.locationManger.delegate = self;
    //控制定位精度,越高耗电量越
    self.locationManger.desiredAccuracy = kCLLocationAccuracyKilometer;
    // 总是授权
    [self.locationManger requestAlwaysAuthorization];
    //    self.locationManger.distanceFilter = 10.0f;
    self.locationManger.allowsBackgroundLocationUpdates = YES;
    [self.locationManger requestAlwaysAuthorization];
    //开始定位
    [self.locationManger startUpdatingLocation];
}

- (void)initNSTimer
{
    self.limit_Time = 100000;
    //添加计时器 60秒内不可以重复点击按钮
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(openTimeLimitAction:) userInfo:nil repeats:YES];
    //如果不添加下面这条语句，在UITableView拖动的时候，会阻塞定时器的调用
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
}

//计时器
- (void)openTimeLimitAction:(NSTimer*)timer
{
    self.limit_Time--;
//    NSLog(@"%d", self.limit_Time);
    if (self.limit_Time == 0) {
        self.limit_Time = 10000;
    }
    self.tipsLable.text = [NSString stringWithFormat:@"%d", self.limit_Time];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    return;
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];

            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSLog(@"city (城市) = %@", city);//城市
            NSLog(@"placemark.name (街道) = %@", placemark.name);//街道
            NSLog(@"placemark.subLocality (区) = %@", placemark.subLocality); //区
            NSLog(@"placemark.country (国家) = %@", placemark.country);//国家
            NSLog(@"placemark.administrativeArea (省) = %@", placemark.administrativeArea); //省
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    //    [manager stopUpdatingLocation];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
