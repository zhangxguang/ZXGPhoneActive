//
//  ZPADisposeNotification.m
//  ZXGPhoneActive
//
//  Created by zxg on 2018/12/4.
//  Copyright © 2018 zxg. All rights reserved.
//

#import "ZPADisposeNotification.h"
#import "ZPANotificationManager.h"

@implementation ZPADisposeNotification

- (void)disposeNotification:(NSDictionary *)notificationDict
{
    NSDate *nowDate = notificationDict[@"nowDate"];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 获取时间间隔
    NSTimeInterval interval = [zone secondsFromGMTForDate:nowDate];
    // 东八区时间
    NSDate *locaDate = [nowDate dateByAddingTimeInterval:interval];
    NSLog(@"locaDate ~~~ %@", locaDate);
    
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    [infoDict setValue:@"又玩手机" forKey:@"title"];
    [infoDict setValue:@"一天天的就知道玩手机" forKey:@"body"];
    
    ZPANotificationManager *notificationManager = [ZPANotificationManager sharedNotificationManager];
    [notificationManager registerNotification:1 notificationInfo:infoDict];
}


@end
