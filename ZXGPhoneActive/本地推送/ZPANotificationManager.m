//
//  ZPANotificationManager.m
//  ZXGPhoneActive
//
//  Created by zxg on 2018/12/4.
//  Copyright © 2018 zxg. All rights reserved.
//

#import "ZPANotificationManager.h"
#import <UserNotifications/UserNotifications.h>

@interface ZPANotificationManager () <UNUserNotificationCenterDelegate>

@end

@implementation ZPANotificationManager

#pragma mark - 单例
+ (id)allocWithZone:(struct _NSZone *)zone
{
    static ZPANotificationManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    
    return instance;
}

+ (instancetype)sharedNotificationManager
{
    static ZPANotificationManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ZPANotificationManager new];
    });
    
    return instance;
}

#pragma mark -
- (void)startNotification
{
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //监听回调事件
    center.delegate = self;
    
    //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }];
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
    }];
}


#pragma mark - UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert);
}

#pragma mark - 使用 UNNotification 本地通知
//使用 UNNotification 本地通知
- (void)registerNotification:(NSInteger)alerTime notificationInfo:(NSDictionary *)infoDict
{
    NSString *title = infoDict[@"title"];
    NSString *body = infoDict[@"body"];
    
    // 使用 UNUserNotificationCenter 来管理通知
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:body
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];

    // 在 alertTime 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:alerTime repeats:NO];

    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];

    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

        NSLog(@"本地推送成功");

    }];
}

@end
